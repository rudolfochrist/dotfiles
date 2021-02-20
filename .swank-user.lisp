;;;; .swank-user.lisp

(defpackage #:swank-user
  (:use :cl)
  (:export
   #:package-symbols))

(in-package #:swank-user)

(defun package-symbols (package-designator)
  (let* ((symbols '())
         (package-string (string-upcase
                          (if (string= "#:" package-designator :end2 2)
                              (subseq package-designator 2)
                              package-designator)))
         (package (find-package package-string)))
    (do-symbols (s package symbols)
      (when (equal (symbol-package s) package)
        (push s symbols)))))
