(in-package #:cl-df.column)


(defclass fundamental-column ()
  ())


;; (defclass fundamental-observer ()
;;   ())


(defclass fundamental-iterator ()
  ())


(defclass fundamental-constructing-iterator (fundamental-iterator)
  ())


(defclass fundamental-pure-iterator (fundamental-iterator)
  ())


(defclass fundamental-pure-constructing-iterator
    (fundamental-constructing-iterator
     fundamental-pure-iterator)
  ())


(defclass complex-iterator (fundamental-iterator)
  ((%subiterator-types :initarg :subiterator-types
                       :type hash-table
                       :initform (make-hash-table :test 'eql)
                       :reader read-subiterator-types)
   (%subiterators :initarg :subiterators
                  :type vector
                  :initform (vect)
                  :reader read-subiterators)))


(defclass sparse-material-column
    (cl-ds.dicts.srrb:transactional-sparse-rrb-vector
     fundamental-column)
  ((%column-size :initarg :column-size
                 :accessor access-column-size
                 :reader column-size
                 :documentation "Highest index+1 in this column.")))


(defun make-sparse-material-column (&key (element-type t))
  (make 'sparse-material-column
        :ownership-tag (cl-ds.common.abstract:make-ownership-tag)
        :column-size 0
        :element-type element-type))


(defclass sparse-material-column-iterator (fundamental-pure-iterator)
  ((%columns :initarg :columns
             :type vector
             :initform (vect)
             :reader read-columns)
   (%stacks :initarg :stacks
            :type vector
            :initform (vect)
            :reader read-stacks)
   (%depth :initarg :depth
           :type fixnum
           :initform 0
           :accessor access-depth)
   (%index :initarg :index
           :accessor access-index
           :type fixnum
           :initform 0)
   (%buffers :initarg :buffers
             :type vector
             :initform (vect)
             :reader read-buffers)
   (%changes :initarg :change-mask
             :type (vector boolean)
             :accessor read-changes)))
