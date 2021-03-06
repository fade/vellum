(cl:in-package #:vellum)

(prove:plan 2)

(let* ((frame-1 (transform (make-table :columns '(a b))
                           (vellum:bind-row (a b)
                             (setf a vellum.table:*current-row*)
                             (setf b (format nil "a~a" a)))
                           :end 5))
       (frame-2 (transform (make-table :columns '(a b))
                           (vellum:bind-row (a b)
                             (setf a vellum.table:*current-row*)
                             (setf b (format nil "b~a" a)))
                           :end 5))
       (result (join :hash :inner
                     `((:frame-1 ,frame-1 a)
                       (:frame-2 ,frame-2 a)))))
  (vellum:show :text result)
  (prove:is (column-count result) 4)
  (prove:is (row-count result) 5))

(prove:finalize)
