(import _set)

# Re-export

(def create _set/create)
(def members _set/members)

# Public api

(defn member? [s x] (true? ((members s) x)))
(defn equal? [s t] (= (members s) (members t)))
(defn add [s & xs] (wrap (struct ;(kvs (members s)) ;(fill xs))))
(defn union [s t] (add s ;(keys (members t))))
(defn diff [s t] (wrap (struct ;(fill (filter |(not (member? t $)) (keys (members s)))))))
(defn remove [s & xs] (diff s (create ;xs)))
(defn intersect [s t] (create ;(filter |(member? s $) (keys (members t)))))

(defn symdiff [s t]
  (create
   ;(filter |(not (member? s $)) (keys (members t)))
   ;(filter |(not (member? t $)) (keys (members s)))))

