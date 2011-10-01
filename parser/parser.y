
%{
#include <yyast/yyast.h>

int yylex();
void yyerror(const char *message);

%}

/* decleration tokens */
%token T_DEF T_CLASS T_PACKAGE T_IMPORT T_AS T_FROM T_SYNC

/* method attributes */
%token T_READ_ONLY T_THREAD_SAFE

/* statement tokens */
%token T_IF T_ELSE T_ELSE_IF T_WHILE T_DO T_FOR T_BREAK T_CONTINUE T_RETURN T_RAISE T_TRY T_CASE T_EXCEPT T_FINALLY
%token T_SPAWN T_WAIT T_LAMBDA

/* primatives */
%token T_NAME
%token T_REAL T_INTEGER T_NONE T_TRUE T_FALSE T_STRING T_REGEX T_ASSEMBLY

/* operators */
%token T_INCREMENT T_DECREMENT T_EQ T_NE T_LE T_GE
%token T_POW T_DIV_FLOOR T_MOD_FLOOR T_SHL T_SHR
%token T_LOGICAL_AND T_LOGICAL_OR T_LOGICAL_XOR T_LOGICAL_NOT
%token T_INPLACE_ADD T_INPLACE_SUB T_INPLACE_MUL T_INPLACE_DIV T_INPLACE_MOD T_INPLACE_AND T_INPLACE_OR T_INPLACE_XOR
%token T_INPLACE_POW T_INPLACE_DIV_FLOOR T_INPLACE_MOD_FLOOR T_INPLACE_SHL T_INPLACE_SHR T_INPLACE_COPY
%token T_IN T_IS T_ISA

%token T_UNKNOWN


%left T_LOGICAL_OR T_LOGICAL_XOR T_LOGICAL_AND
%left T_IN T_IS T_ISA
%left '<' '>' T_EQ T_NE T_LE T_GE
%left '|' '^' '&'
%left T_SHL T_SHR
%left '-' '+'
%left '*' '/' '%' T_DIV_FLOOR T_MOD_FLOOR
%left T_POW
%left '.'

%left P_UMINUS '~' T_LOGICAL_NOT P_LENGTH
%left P_TERTARY P_LAMBDA

%right T_IF T_ELSE
%right '=' T_INPLACE_ADD T_INPLACE_SUB T_INPLACE_MUL T_INPLACE_DIV T_INPLACE_MOD T_INPLACE_AND T_INPLACE_OR T_INPLACE_XOR
%right T_INPLACE_POW T_INPLACE_DIV_FLOOR T_INPLACE_MOD_FLOOR T_INPLACE_SHL T_INPLACE_SHR T_INPLACE_COPY

%nonassoc ',' ':' '[' '(' '{'  T_LAMBDA

%start module

%defines
%error-verbose
%verbose
%%

/* Dictionary content. */
ditem
    : expression ':' expression                                                             { $$ = NODE(&$1, &$3, "ditm", &$1, &$3); }
    ;

ditem_list
    : ditem                                                                                 { $$ = LIST(&$1, &$1, &$1); }
    | ditem_list ',' ditem                                                                  { $$ = LIST(&$1, &$3, &$1, &$3); }
    ;

dictionary_content
    : ':'                                                                                   { $$ = EMPTYLIST; }
    | ditem_list                                                                            { $$ = $1; }
    | ditem_list ','                                                                        { $$ = $1; }
    ;

/* List content. */
litem
    : expression                                                                            { $$ = $1; }
    ;

litem_list
    : litem                                                                                 { $$ = LIST(&$1, &$1, &$1); }
    | litem_list ',' litem                                                                  { $$ = LIST(&$1, &$3, &$1, &$3); }
    ;

list_content
    : ','                                                                                   { $$ = EMPTYLIST; }
    | litem_list                                                                            { $$ = $1; }
    | litem_list ','                                                                        { $$ = $1; }
    ;

/* Tuple content. */
tuple_content
    : ','                                                                                   { $$ = EMPTYLIST; }
    | litem ','                                                                             { $$ = $1; }
    | litem ',' litem_list                                                                  { $$ = LIST(&$1, &$3, &$1, &$3); }
    | litem ',' litem_list ','                                                              { $$ = LIST(&$1, &$4, &$1, &$3); }
    ;

/* Argument definition content. */
def_item
    : T_NAME                                                                                { $$ = NODE(&$1, &$1, "farg", &$1, PASS); }
    | T_NAME '=' expression                                                                 { $$ = NODE(&$1, &$3, "farg", &$1, &$3); }
    ;

def_item_list
    : def_item                                                                              { $$ = LIST(&$1, &$1, &$1); }
    | def_item_list ',' def_item                                                            { $$ = LIST(&$1, &$3, &$1, &$3); }
    ;

def_arguments
    :                                                                                       { $$ = EMPTYLIST; }
    | ','                                                                                   { $$ = EMPTYLIST; }
    | def_item_list                                                                         { $$ = $1; }
    | def_item_list ','                                                                     { $$ = $1; }
    ;

/* Argument call content. */
call_item
    : expression                                                                            { $$ = NODE(&$1, &$1, "carg", PASS, &$1); }
    | T_NAME '=' expression                                                                 { $$ = NODE(&$1, &$3, "carg", &$1, &$3); }
    ;

call_item_list
    : call_item                                                                             { $$ = LIST(&$1, &$1, &$1); }
    | call_item_list ',' call_item                                                          { $$ = LIST(&$1, &$3, &$1, &$3); }
    ;

call_arguments
    :                                                                                       { $$ = EMPTYLIST; }
    | ','                                                                                   { $$ = EMPTYLIST; }
    | call_item_list                                                                        { $$ = $1; }
    | call_item_list ','                                                                    { $$ = $1; }
    ;

/* fully qualified name, for package */
fqname_content
    : T_NAME                                                                                { $$ = LIST(&$1, &$1, &$1); }
    | fqname_content '.' T_NAME                                                             { $$ = LIST(&$1, &$3, &$1, &$3); }
    ;

fqname
    : fqname_content                                                                        { $$ = NODE(&$1, &$1, "fqnm", &$1); }
    ;

fqnames_content
    : fqname                                                                                { $$ = LIST(&$1, &$1, &$1); }
    | fqnames_content ',' fqname                                                            { $$ = LIST(&$1, &$3, &$1, &$3); }
    ;

fqnames
    : fqnames_content                                                                       { $$ = NODE(&$1, &$1, "fqns", &$1); }
    ;

/* A list of names */
names_content
    : T_NAME                                                                                { $$ = LIST(&$1, &$1, &$1); }
    | names ',' T_NAME                                                                      { $$ = LIST(&$1, &$3, &$1, &$3); }
    ;

names
    : names_content                                                                         { $$ = NODE(&$1, &$1, "nms ", &$1); }
    ;

/* Block */
statement_list
    : statement                                                                             { $$ = LIST(&$1, &$1, &$1); }
    | statement_list statement                                                              { $$ = LIST(&$1, &$2, &$1, &$2); }
    ;

block_content
    :                                                                                       { $$ = NODE(END, END, "bloc", EMPTYLIST); }
    | statement_list                                                                        { $$ = NODE(&$1, &$1, "bloc", &$1); }
    ;

/* Expressions */
expression
    : T_REAL                                                                                { $$ = $1; }
    | T_INTEGER                                                                             { $$ = $1; }
    | T_NONE                                                                                { $$ = $1; }
    | T_TRUE                                                                                { $$ = $1; }
    | T_FALSE                                                                               { $$ = $1; }
    | T_STRING                                                                              { $$ = $1; }
    | T_REGEX                                                                               { $$ = $1; }
    | T_NAME                                                                                { $$ = $1; }
    | '{' dictionary_content '}'                                                            { $$ = NODE(&$1, &$3, "dict", &$2); }
    | '{' list_content '}'                                                                  { $$ = NODE(&$1, &$3, "set ", &$2); }
    | '[' dictionary_content ']'                                                            { $$ = NODE(&$1, &$3, "skip", &$2); }
    | '[' list_content ']'                                                                  { $$ = NODE(&$1, &$3, "list", &$2); }
    | '(' tuple_content ')'                                                                 { $$ = NODE(&$1, &$3, "tupl", &$2); }
    | '{' expression T_FOR expression T_IN expression '}'                                   { $$ = NODE(&$1, &$7, "dcmp", &$2, &$4, &$6, PASS); }
    | '[' expression T_FOR expression T_IN expression ']'                                   { $$ = NODE(&$1, &$7, "lcmp", &$2, &$4, &$6, PASS); }
    | '(' expression T_FOR expression T_IN expression ')'                                   { $$ = NODE(&$1, &$7, "tcmp", &$2, &$4, &$6, PASS); }
    | '{' expression T_FOR expression T_IN expression T_IF expression '}'                   { $$ = NODE(&$1, &$9, "dcmp", &$2, &$4, &$6, &$8); }
    | '[' expression T_FOR expression T_IN expression T_IF expression ']'                   { $$ = NODE(&$1, &$9, "lcmp", &$2, &$4, &$6, &$8); }
    | '(' expression T_FOR expression T_IN expression T_IF expression ')'                   { $$ = NODE(&$1, &$9, "tcmp", &$2, &$4, &$6, &$8); }
    | '~' expression                                                                        { $$ = NODE(&$1, &$2, "~   ", &$2); }
    | '-' expression %prec P_UMINUS                                                         { $$ = NODE(&$1, &$2, "-   ", &$2); }
    | '|' expression '|' %prec P_LENGTH                                                     { $$ = NODE(&$1, &$2, "| | ", &$2); }
    | T_LOGICAL_NOT expression                                                              { $$ = NODE(&$1, &$2, "not ", &$2);  }
    | expression '.' T_NAME                                                                 { $$ = NODE(&$1, &$3, ".   ", &$1, &$3); }
    | expression T_SHL expression                                                           { $$ = NODE(&$1, &$3, "<<  ", &$1, &$3);}
    | expression T_SHR expression                                                           { $$ = NODE(&$1, &$3, ">>  ", &$1, &$3); }
    | expression T_POW expression                                                           { $$ = NODE(&$1, &$3, "**  ", &$1, &$3); }
    | expression '*' expression                                                             { $$ = NODE(&$1, &$3, "*   ", &$1, &$3); }
    | expression T_DIV_FLOOR expression                                                     { $$ = NODE(&$1, &$3, "//  ", &$1, &$3); }
    | expression '/' expression                                                             { $$ = NODE(&$1, &$3, "/   ", &$1, &$3); }
    | expression T_MOD_FLOOR expression                                                     { $$ = NODE(&$1, &$3, "%%  ", &$1, &$3); }
    | expression '%' expression                                                             { $$ = NODE(&$1, &$3, "%   ", &$1, &$3); }
    | expression '+' expression                                                             { $$ = NODE(&$1, &$3, "+   ", &$1, &$3); }
    | expression '-' expression                                                             { $$ = NODE(&$1, &$3, "-   ", &$1, &$3); }
    | expression '&' expression                                                             { $$ = NODE(&$1, &$3, "&   ", &$1, &$3); }
    | expression '^' expression                                                             { $$ = NODE(&$1, &$3, "^   ", &$1, &$3); }
    | expression '|' expression                                                             { $$ = NODE(&$1, &$3, "|   ", &$1, &$3); }
    | expression T_IS expression                                                            { $$ = NODE(&$1, &$3, "is  ", &$1, &$3); }
    | expression T_EQ expression                                                            { $$ = NODE(&$1, &$3, "==  ", &$1, &$3); }
    | expression T_NE expression                                                            { $$ = NODE(&$1, &$3, "!=  ", &$1, &$3); }
    | expression '<' expression                                                             { $$ = NODE(&$1, &$3, "<   ", &$1, &$3); }
    | expression '>' expression                                                             { $$ = NODE(&$1, &$3, ">   ", &$1, &$3); }
    | expression T_LE expression                                                            { $$ = NODE(&$1, &$3, "<=  ", &$1, &$3); }
    | expression T_GE expression                                                            { $$ = NODE(&$1, &$3, ">=  ", &$1, &$3); }
    | expression T_LOGICAL_AND expression                                                   { $$ = NODE(&$1, &$3, "and ", &$1, &$3); }
    | expression T_LOGICAL_XOR expression                                                   { $$ = NODE(&$1, &$3, "xor ", &$1, &$3); }
    | expression T_LOGICAL_OR expression                                                    { $$ = NODE(&$1, &$3, "or  ", &$1, &$3); }
    | expression T_IN expression                                                            { $$ = NODE(&$1, &$3, "in  ", &$1, &$3); }
    | expression T_IF expression T_ELSE expression                                          { $$ = NODE(&$1, &$5, "?:  ", &$1, &$3, &$5); }
    | expression '[' ']'                                                                    { $$ = NODE(&$1, &$3, "x[] ", &$1, PASS); }
    | expression '[' expression ']'                                                         { $$ = NODE(&$1, &$4, "x[] ", &$1, &$3); }
    | expression '['            ':'                           ']'                           { $$ = NODE(&$1, &$4, "x[:]", PASS, PASS, PASS); }
    | expression '[' expression ':'                           ']'                           { $$ = NODE(&$1, &$4, "x[:]", &$3       , PASS, PASS); }
    | expression '['            ':' expression                ']'                           { $$ = NODE(&$1, &$4, "x[:]", PASS, &$4       , PASS); }
    | expression '[' expression ':' expression                ']'                           { $$ = NODE(&$1, &$4, "x[:]", &$3       , &$5        , PASS); }
    | expression '[' expression ':'            ':' expression ']'                           { $$ = NODE(&$1, &$4, "x[:]", &$3       , PASS, &$6        ); }
    | expression '['            ':' expression ':' expression ']'                           { $$ = NODE(&$1, &$4, "x[:]", PASS, &$4       , &$6        ); }
    | expression '[' expression ':' expression ':' expression ']'                           { $$ = NODE(&$1, &$4, "x[:]", &$3       , &$5        , &$7 ); }
    | expression '(' call_arguments ')'                                                     { $$ = NODE(&$1, &$4, "x() ", &$1, &$3); }
    | T_LAMBDA def_arguments ':' expression %prec P_LAMBDA                                  { $$ = NODE(&$1, &$4, "lamd", &$2, &$4); }
    | '(' expression ')'                                                                    { $$ = $2; }
    ;

/* an else if is always two items, or ends in a trailing single item else.
 */
if_continue
    : T_ELSE_IF expression '{' block_content '}'                                            { $$ = LIST(&$1, &$5, &$2, &$4); }
    | T_ELSE_IF expression '{' block_content '}' if_continue                                { $$ = LIST(&$1, &$6, &$2, &$4, &$6); }
    | T_ELSE_IF expression '{' block_content '}' T_ELSE '{' block_content '}'               { $$ = LIST(&$1, &$9, &$2, &$4, &$8); }
    ;

/* an else if is always three items, or ends in a trailing single item finally.
 */
except_continue
    : T_EXCEPT '*'        T_AS expression '{' block_content '}'                                    { $$ = LIST(&$1,  &$7, PASS, &$4, &$6); }
    | T_EXCEPT expression T_AS expression '{' block_content '}'                                    { $$ = LIST(&$1,  &$7, &$2        , &$4, &$6); }
    | T_EXCEPT '*'        T_AS expression '{' block_content '}' except_continue                    { $$ = LIST(&$1,  &$8, PASS, &$4, &$6, &$8); }
    | T_EXCEPT expression T_AS expression '{' block_content '}' except_continue                    { $$ = LIST(&$1,  &$8, &$2        , &$4, &$6, &$8); }
    | T_EXCEPT '*'        T_AS expression '{' block_content '}' T_FINALLY '{' block_content '}'    { $$ = LIST(&$1, &$11, PASS, &$4, &$6, &$10); }
    | T_EXCEPT expression T_AS expression '{' block_content '}' T_FINALLY '{' block_content '}'    { $$ = LIST(&$1, &$11, &$2        , &$4, &$6, &$10); }
    ;

/* an case is always two items, or ends in a trailing else item.
 */
case_continue
    : T_IS expression '{' block_content '}'                                                         { $$ = LIST(&$1, &$5, &$2, &$4); }
    | T_IS expression '{' block_content '}' case_continue                                           { $$ = LIST(&$1, &$6, &$2, &$4, &$6); }
    | T_IS expression '{' block_content '}' T_ELSE '{' block_content '}'                            { $$ = LIST(&$1, &$9, &$2, &$4, &$8); }
    ;

statement
    : ';'                                                                                               { $$ = EMPTYLIST; }
    | T_ASSEMBLY                                                                                        { $$ = $1; }
    | expression '(' call_arguments ')' ';'                                                             { $$ = NODE(&$1, &$5, "x() ", &$1, &$3); }
    | expression '=' expression ';'                                                                     { $$ = NODE(&$1, &$4, "=   ", &$1, &$3); }
    | expression T_INPLACE_COPY expression ';'                                                          { $$ = NODE(&$1, &$4, ":=  ", &$1, &$3); }
    | expression T_INPLACE_ADD expression ';'                                                           { $$ = NODE(&$1, &$4, "+=  ", &$1, &$3); }
    | expression T_INPLACE_SUB expression ';'                                                           { $$ = NODE(&$1, &$4, "-=  ", &$1, &$3); }
    | expression T_INPLACE_MUL expression ';'                                                           { $$ = NODE(&$1, &$4, "*=  ", &$1, &$3); }
    | expression T_INPLACE_DIV expression ';'                                                           { $$ = NODE(&$1, &$4, "/=  ", &$1, &$3); }
    | expression T_INPLACE_MOD expression ';'                                                           { $$ = NODE(&$1, &$4, "%=  ", &$1, &$3); }
    | expression T_INPLACE_DIV_FLOOR expression ';'                                                     { $$ = NODE(&$1, &$4, "//= ", &$1, &$3); }
    | expression T_INPLACE_MOD_FLOOR expression ';'                                                     { $$ = NODE(&$1, &$4, "%%= ", &$1, &$3); }
    | expression T_INPLACE_SHL expression ';'                                                           { $$ = NODE(&$1, &$4, "<<= ", &$1, &$3); }
    | expression T_INPLACE_SHR expression ';'                                                           { $$ = NODE(&$1, &$4, ">>= ", &$1, &$3); }
    | expression T_INPLACE_AND expression ';'                                                           { $$ = NODE(&$1, &$4, "&=  ", &$1, &$3); }
    | expression T_INPLACE_OR expression ';'                                                            { $$ = NODE(&$1, &$4, "|=  ", &$1, &$3); }
    | expression T_INPLACE_XOR expression ';'                                                           { $$ = NODE(&$1, &$4, "^=  ", &$1, &$3); }
    | T_BREAK ';'                                                                                       { $$ = EMPTYNODE(&$1, &$2, "brea"); }
    | T_CONTINUE ';'                                                                                    { $$ = EMPTYNODE(&$1, &$2, "cont"); }
    | T_RETURN expression ';'                                                                           { $$ = NODE(&$1, &$3, "retu", &$2); }
    | T_RAISE expression ';'                                                                            { $$ = NODE(&$1, &$3, "rais", &$2); }
    | T_FOR expression T_IN expression ';'                                                              { $$ = NODE(&$1, &$5, "for ", &$2, &$4, PASS, PASS); }
    | T_FOR expression T_IN expression '{' block_content '}'                                            { $$ = NODE(&$1, &$7, "for ", &$2, &$4, &$6        , PASS); }
    | T_FOR expression T_IN expression                       T_ELSE '{' block_content '}'               { $$ = NODE(&$1, &$8, "for ", &$2, &$4, PASS, &$7);   }
    | T_FOR expression T_IN expression '{' block_content '}' T_ELSE '{' block_content '}'               { $$ = NODE(&$1, &$4, "for ", &$2, &$4, &$6        , &$10);  }
    |                            T_WHILE expression ';'                                                 { $$ = NODE(&$1,  &$3, "whil", PASS, &$2, PASS, PASS); }
    |                            T_WHILE expression                       T_ELSE '{' block_content '}'  { $$ = NODE(&$1,  &$6, "whil", PASS, &$2, PASS, &$6);   }
    |                            T_WHILE expression '{' block_content '}'                               { $$ = NODE(&$1,  &$5, "whil", PASS, &$2, &$4        , PASS); }
    |                            T_WHILE expression '{' block_content '}' T_ELSE '{' block_content '}'  { $$ = NODE(&$1,  &$9, "whil", PASS, &$2, &$4        , &$8);   }
    | T_DO '{' block_content '}' T_WHILE expression ';'                                                 { $$ = NODE(&$1,  &$7, "whil", &$3,         &$6, PASS, PASS); }
    | T_DO '{' block_content '}' T_WHILE expression                       T_ELSE '{' block_content '}'  { $$ = NODE(&$1, &$10, "whil", &$3,         &$6, PASS, &$9);   }
    | T_DO '{' block_content '}' T_WHILE expression '{' block_content '}'                               { $$ = NODE(&$1,  &$9, "whil", &$3,         &$6, &$8,         PASS); }
    | T_DO '{' block_content '}' T_WHILE expression '{' block_content '}' T_ELSE '{' block_content '}'  { $$ = NODE(&$1, &$13, "whil", &$3,         &$6, &$8,         &$12);  }
    | T_IF expression '{' block_content '}'                                                             { $$ = NODE(&$1, &$5, "if  ", &$2, &$4); }
    | T_IF expression '{' block_content '}' if_continue                                                 { $$ = NODE(&$1, &$6, "if  ", &$2, &$4, &$6); }
    | T_IF expression '{' block_content '}' T_ELSE '{' block_content '}'                                { $$ = NODE(&$1, &$9, "if  ", &$2, &$4, &$8); }
    | T_TRY '{' block_content '}'                                                                       { $$ = NODE(&$1, &$4, "try ", &$2); }
    | T_TRY '{' block_content '}' except_continue                                                       { $$ = NODE(&$1, &$5, "try ", &$2, &$4); }
    | T_TRY '{' block_content '}' T_FINALLY '{' block_content '}'                                       { $$ = NODE(&$1, &$8, "try ", &$2, &$7); }
    | T_CASE expression case_continue                                                                   { $$ = NODE(&$1, &$3, "case", &$2, &$3); }
    ;

class_item
    : T_DEF T_NAME '(' def_arguments ')' '{' block_content '}'                              { $$ = NODE(&$1, &$8, "func", &$2, &$4, &$7); }
    ;

class_list
    : class_item                                                                            { $$ = LIST(&$1, &$1, &$1); }
    | class_list class_item                                                                 { $$ = LIST(&$1, &$2, &$1, &$2); }
    ;

class_content
    :                                                                                       { $$ = EMPTYLIST; }
    | class_list                                                                            { $$ = $1; }
    ;

module_item
    : T_FROM fqname T_IMPORT '*' ';'                                                        { $$ = NODE(&$1, &$5, "impo", &$2, PASS, PASS); }
    | T_FROM fqname T_IMPORT names ';'                                                      { $$ = NODE(&$1, &$5, "impo", &$2, &$4,         PASS); }
    | T_FROM fqname T_IMPORT '*'   T_AS T_NAME ';'                                          { $$ = NODE(&$1, &$7, "impo", &$2, PASS, &$6); }
    | T_FROM fqname T_IMPORT names T_AS T_NAME ';'                                          { $$ = NODE(&$1, &$7, "impo", &$2, &$4,         &$6); }
    | T_CLASS T_NAME '(' fqnames ')' '{' class_content '}'                                  { $$ = NODE(&$1, &$8, "clas", &$2, &$4, &$7); }
    | T_DEF T_NAME '(' def_arguments ')' '{' block_content '}'                              { $$ = NODE(&$1, &$8, "func", &$2, &$4, &$7); }
    ;

module_list
    : module_item                                                                           { $$ = LIST(&$1, &$1, &$1); }
    | module_list module_item                                                               { $$ = LIST(&$1, &$2, &$1, &$2); }
    ;

module_content
    :                                                                                       { $$ = EMPTYLIST; }
    | module_list                                                                           { $$ = LIST(&$1, &$1, &$1); }
    ;

module
    : module_content                                                                        { ya_start = $$ = NODE(&$1, &$1, "modu", &$1); }
    ;

%%

void yyerror(const char *message)
{
    ya_error(message);
}

int main(int argc, char *argv[])
{
    return ya_main(argc, argv, "tast");
}

