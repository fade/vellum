(cl:in-package #:vellum.selection)


(defclass content ()
  ())


(defclass between (content)
  ((%from :initarg :from
          :reader read-from)
   (%to :initarg :to
        :reader read-to))
  (:default-initargs
   :from nil
   :to nil))


(defun between (&key from to)
  (make 'between
         :from from
         :to to))


(defgeneric content (selection translate current-position limit))


(defgeneric address-range (selector/sequence translate limit))


(defclass selector ()
  ((%callback :initarg :callback
              :reader read-callback)))


(defmethod content ((selection between) translate
                    current-position limit)
  (let ((from (funcall translate
                       (or (read-from selection)
                           current-position)))
        (to (funcall translate
                     (or (read-to selection)
                         limit))))
    (cl-ds:iota-range :from from
                      :to to
                      :by (if (<= from to) 1 -1))))


(defun s (&rest forms)
  (make
   'selector
   :callback (lambda (translate limit &aux (position -1))
               (~> forms
                   (cl-ds.alg:multiplex
                    :key (lambda (x)
                           (typecase x
                             (cl-ds:traversable x)
                        (sequence x)
                        (content (content x translate (1+ position) limit))
                        (atom (list x)))))
                   (cl-ds.alg:on-each (lambda (x)
                                        (setf position
                                              (funcall translate x))))))))


(define-condition name-when-selecting-row (cl-ds:invalid-value)
  ())


(defmethod address-range ((selector/sequence selector) translate limit)
  (funcall (read-callback selector/sequence)
           translate
           limit))


(defmethod address-range ((selector/sequence sequence) translate limit)
  (cl-ds.alg:on-each selector/sequence (lambda (x) (funcall translate x))))
