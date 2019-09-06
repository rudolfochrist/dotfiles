;;; common init file for various CLs  -*- mode: lisp; -*-
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

#+quicklisp
(ql:quickload :clutils :silent t)

#+abcl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :abcl-contrib)
  (require :abcl-asdf)
  (require :jss))

;;; Allegro CL REPL
#+sbcl
(progn
  (ignore-errors (require 'sb-aclrepl))
  (when (find-package :sb-aclrepl)
    (load "~/.sb-aclrepl.lisp")
    (push :aclrepl *features*)))


;;; machine information
(defun machine-info ()
  "Print this host's details."
  (format t "~@{~A: ~A~^~%~}~%"
          "Machine Information"  ""
          "-- Arch"  (machine-type)
          "-- CPU"  (machine-version)
          "-- OS" (software-type)
          "-- Version" (software-version)
          "-- Hostname"  (machine-instance)
          "-- HOME"  (user-homedir-pathname)
          "-- Site Name"  (list (short-site-name) (long-site-name))
          "Lisp Information"  ""
          "-- Implementation"  (lisp-implementation-type)
          "-- Version"  (lisp-implementation-version)))
