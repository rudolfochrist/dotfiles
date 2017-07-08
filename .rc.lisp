;;; common init file for various CLs
;;; see also http://www.cliki.net/Common%20Lisp%20implementation
;;; for startup file names
;;; - ~./clisprc.lisp (clisp)
;;; - ~/.cmucl-init.lisp (cmucl)
;;; - ~/.eclrc (ecl)
;;; - ~/.ccl-init.lisp (ccl)
;;; - ~/.sbclrc (sbcl)
;;; - ~/.abclrc (abcl)
;;; - ~/.mkclrc (mkcl)
;;; - ~/.clinit.cl (acl/allegro cl]

#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

#+sbcl
(setf sb-impl::*default-external-format* :utf-8)

#+abcl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :abcl-contrib)
  (require :abcl-asdf)
  (require :jss))

;;; regex
#+quicklisp (ql:quickload :cl-ppcre)

;;; unit testing
#+quicklisp (ql:quickload :fiveam)

;;; personal utilities
#+ (and asdf3.1 quicklisp (not abcl))
(ql:quickload :clutils)
