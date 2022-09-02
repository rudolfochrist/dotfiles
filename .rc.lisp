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
;;; - ~/.clinit.cl (acl/allegro cl)

;;; with-debug
(proclaim '(optimize (speed 0) (compilation-speed 0) (safety 3) (debug 3)))

(require 'asdf)
(require 'sb-aclrepl)

#+sbcl
(setf sb-impl::*default-external-format* :utf-8)

(asdf:load-system "cl-manager" :verbose nil)


;;; Machine information
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
