(cl:in-package #:cl-user)


(defpackage vellum.header
  (:use #:cl #:vellum.aux-package)
  (:nicknames #:vellum.header)
  (:export
   #:*header*
   #:*row*
   #:*validate-predicates*
   #:bind-row
   #:bind-row-closure
   #:brr
   #:check-column-signatures-compatibility
   #:check-predicate
   #:column-count
   #:column-predicate
   #:column-signature
   #:column-specs
   #:column-type
   #:concatenate-headers
   #:constantly-t
   #:current-row-as-vector
   #:ensure-index
   #:frame-range-mixin
   #:fundamental-header
   #:header
   #:headers-incompatible
   #:index-to-name
   #:invalid-input-for-row
   #:invalid-name
   #:keep-old-value
   #:make-header
   #:make-row
   #:name-duplicated
   #:name-to-index
   #:no-column
   #:no-header
   #:predicate-failed
   #:provide-new-value
   #:read-header
   #:read-name
   #:read-new-value
   #:row
   #:row-at
   #:rr
   #:select-columns
   #:set-row
   #:set-to-null
   #:skip-row
   #:skip-row
   #:standard-header
   #:unable-to-construct-row
   #:validated-frame-range-mixin
   #:value
   #:with-header))
