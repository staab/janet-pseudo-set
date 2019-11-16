(defn- build-t [xs v &opt t]
  (default t @{})
  (each x xs (put t x v))
  t)

(defn create [& xs]
  (let [t (build-t xs true)]
    (defn pseudo-set [] t)))

(defn clone [s] (create ;(s)))
(defn members [s] (s))
(defn member? [s x] (true? ((s) x)))
(defn add [s & xs] (let [t (clone s)] (build-t xs true t) t))
(defn union [s t] (add s ;(t)))
(defn remove [s & xs] (let [t (clone s)] (build-t xs nil t) t))
(defn diff [s t] (remove s ;(t)))
(defn intersect [s t] (create ;(filter |(member? s $) t)))
(defn symdiff [s t] (create ;(filter |(not (member? s $)) t)))
