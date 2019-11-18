(defn- build-t [xs v &opt t]
  (default t @{})
  (each x xs (put t x v))
  t)

(defn create [& xs]
  (let [t (build-t xs true)]
    (defn pseudo-set [] t)))

(defn members [s] (keys (s)))
(defn member? [s x] (true? ((s) x)))
(defn equal? [s t] (deep= (s) (t)))
(defn clone [s] (create ;(members s)))
(defn add [s & xs] (let [t (clone s)] (build-t xs true (t)) t))
(defn union [s t] (add s ;(members t)))
(defn remove [s & xs] (let [t (clone s)] (build-t xs nil (t)) t))
(defn diff [s t] (remove s ;(members t)))
(defn intersect [s t] (create ;(filter |(member? s $) (members t))))

(defn symdiff [s t]
  (create
   ;(filter |(not (member? s $)) (members t))
   ;(filter |(not (member? t $)) (members s))))
