(use staab.assert/assert)
(import staab.pseudo-set/pseudo-set :as set)

(defn check-copy [s f & args]
  (let [s2 (f s ;args)]
    (assert (not= s s2) "Set function did not copy its argument")
    s2))

(defn check-members [s f & args]
  (set/members (check-copy s f ;args)))

(assert-deep= @[1 2 3] (set/members (set/create 1 2 3)))
(assert= true (set/member? (set/create 1 2 3) 3))
(assert= false (set/member? (set/create 1 2 3) :a))

(assert
 (set/equal? (set/create 1 2 3) (set/create 1 2 3))
 "Equivalent sets are not equal")

(assert
 (not (set/equal? (set/create 1 2 3 4) (set/create 1 2 3)))
 "Non-equivalent sets are equal")

(let [s (set/create 1 2 3)]
  (assert
   (set/equal? (check-copy s set/clone) s)
   "Clone created non-equal sets"))

(assert-deep= @[1 2 3 :a :b] (check-members (set/create 1 2 3) set/add :a :b))
(assert-deep= @[1 2 3 :a :b] (check-members (set/create 1 2 3) set/union (set/create :a :b)))
(assert-deep= @[2] (check-members (set/create 1 2 3) set/remove 1 3))
(assert-deep= @[2] (check-members (set/create 1 2 3) set/diff (set/create 1 3)))
(assert-deep= @[1 3] (check-members (set/create 1 2 3) set/intersect (set/create 1 3 :a)))
(assert-deep= @[2 :a] (check-members (set/create 1 2 3) set/symdiff (set/create 1 3 :a)))
