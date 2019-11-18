# Utils

(defn- wrap [m] (fn pseudo-set [] m))
(defn- fill [ks] (let [a @[]] (each k ks (array/push a k) (array/push a true)) a))

# Public api

(defn create [& xs] (wrap (struct ;(fill xs))))
(defn members [s] (tuple ;(keys (s))))
(defn member? [s x] (true? ((s) x)))
(defn equal? [s t] (= (s) (t)))
(defn add [s & xs] (wrap (struct ;(kvs (s)) ;(fill xs))))
(defn union [s t] (add s ;(keys (t))))
(defn diff [s t] (wrap (struct ;(fill (filter |(not (member? t $)) (keys (s)))))))
(defn remove [s & xs] (diff s (create ;xs)))
(defn intersect [s t] (create ;(filter |(member? s $) (keys (t)))))

(defn symdiff [s t]
  (create
   ;(filter |(not (member? s $)) (keys (t)))
   ;(filter |(not (member? t $)) (keys (s)))))
