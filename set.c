#include <janet.h>
#include "util.h"

typedef struct {
    JanetArray* members;
} Set;

static int set_mark(void *p, size_t size) {
    (void) size;

    Set* set = (Set*)p;

    janet_mark(janet_wrap_array(set->members));

    return 0;
}

static void set_tostring(void *p, JanetBuffer *buffer) {
    Set* set = (Set *)p;

    janet_buffer_push_cstring(buffer, "<set ");
    janet_to_string_b(buffer, *(Janet*)set->members);
    janet_buffer_push_cstring(buffer, ">");
}

static struct JanetAbstractType Set_jt = {
    "set",
    NULL,
    set_mark,
    NULL,
    NULL,
    NULL,
    NULL,
    set_tostring,
    NULL,
    NULL,
    NULL,
    NULL
};

static Janet set_create(int32_t argc, Janet *argv) {
    JanetArray* members = janet_array(argc);

    for (int i = 0; i < argc; i++) {
        janet_array_push(members, argv[i]);
    }

    Set *set = janet_abstract(&Set_jt, sizeof(Set));
    set->members = members;

    return janet_wrap_abstract(set);
}

static Janet set_members(int32_t argc, Janet *argv) {
    janet_fixarity(argc, 1);

    Set* set = janet_getabstract(argv, 0, &Set_jt);

    return janet_wrap_array(set->members);
}

static const JanetReg cfuns[] = {
    {"create", set_create,
     "(set/create ;members)\n\n"
     "Create a set with optional members."},
    {"members", set_members,
     "(set/members set)\n\n"
     "Get members of the set as an array."},
    {NULL, NULL, NULL}
};

JANET_MODULE_ENTRY(JanetTable *env) {
  janet_cfuns(env, "set", cfuns);
  janet_register_abstract_type(&Set_jt);
}
