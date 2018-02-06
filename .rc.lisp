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

#+abcl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :abcl-contrib)
  (require :abcl-asdf)
  (require :jss))

;;; libs
#+quicklisp (ql:quickload '(:clutils) :silent t)

;;; Allegro CL REPL
#+sbcl
(progn
  (ignore-errors (require 'sb-aclrepl))
  (when (find-package :sb-aclrepl)
    (push :aclrepl *features*)))

#+aclrepl
(defun ovwrt-exit-cmd (&optional (status 0))
  "Exit command overwrite that doesn't terminate threads."
  #+sb-thread
  (flet ((other-threads ()
           (delete sb-thread:*current-thread*
                   (sb-thread:list-all-threads))))
    (let ((other-threads (other-threads)))
      (when other-threads
        (format *standard-output* "There exists the following processes~%")
        (format *standard-output* "~{~A~%~}" other-threads)
        (format *standard-output* "Do you want to exit lisp anyway [n]? ")
        (force-output *standard-output*)
        (let ((input (string-trim '(#\Space #\Tab #\Return)
                                  (read-line *standard-input*))))
          (unless (and (plusp (length input))
                       (or (char= #\y (char input 0))
                           (char= #\Y (char input 0))))
            (return-from ovwrt-exit-cmd))))))
  (sb-ext:exit :code status))

#+aclrepl
;;; This is super hackish.
(let ((cmd (sb-aclrepl::find-cmd "exit")))
  (setf (sb-aclrepl::cmd-table-entry-func cmd) #'ovwrt-exit-cmd)
  (sb-aclrepl::%add-entry
   cmd
   (sb-aclrepl::cmd-table-entry-abbr-len cmd)))

#+(and aclrepl quicklisp)
(sb-aclrepl:alias ("ql" 1 "quickload system") (system)
                  (ql:quickload system))

#+(and aclrepl asdf)
(sb-aclrepl:alias ("make" 1 "asdf:make system") (system)
                  (asdf:make system))

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
