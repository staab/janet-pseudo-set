(declare-project
 :name "janet-set"
 :description "A set library for Janet"
 :dependencies [])

(declare-native
  :name "_set"
  :source ["set.c"])

(declare-source
  :source ["set.janet"])
