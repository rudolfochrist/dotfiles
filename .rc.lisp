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

;;;
;;; see also: https://github.com/marcoheisig/common-lisp-tweaks
;;;

;;; with-debug
;;; give me more details during development
#+sbcl
(progn
  ;; and make sure I keep more details during development.
  (sb-ext:restrict-compiler-policy 'safety 3)
  (sb-ext:restrict-compiler-policy 'debug 3)
  (sb-ext:restrict-compiler-policy 'space 3)
  (setf sb-impl::*default-external-format* :utf-8)
  ;; (setf sb-ext:*on-package-variance* '(:warn (:skynk :slynk-backend :slynk-api :swank :swank-backend) :error t))
  ;; xref sbcl sources/contrib
  ;; see: https://github.com/Homebrew/homebrew-core/blob/master/Formula/s/sbcl.rb
  ;; adjusted for MacPorts.
  ;; Make sure to copy the src of sbcl manually to /opt/local/lib/sbcl
  (setf (logical-pathname-translations "SYS")
        '(("SYS:SRC;**;*.*.*" #p"/opt/local/lib/sbcl/src/**/*.*")
          ("SYS:CONTRIB;**;*.*.*" #p"/opt/local/lib/sbcl/contrib/**/*.*"))))

(require 'asdf)
(setf *print-level* 50)
(setf *print-length* 200)

#+sbcl
(require 'sb-aclrepl)

#+asdf
(progn
  (defun current-directory-system-definition-searcher (system-name)
    (probe-file (make-pathname :defaults (uiop:getcwd)
                               :name (asdf:primary-system-name system-name)
                               :type "asd")))
  (defun vendor-directory-system-definition-searcher (system-name)
    (dolist (dir (uiop:subdirectories (merge-pathnames "vendor/" (uiop:getcwd))))
      (let ((asd-file (make-pathname :defaults dir
                                     :name (asdf:primary-system-name system-name)
                                     :type "asd")))
        (when (probe-file asd-file)
          (return asd-file)))))
  (setf asdf:*system-definition-search-functions*
        (append asdf:*system-definition-search-functions*
                (list 'current-directory-system-definition-searcher
                      'vendor-directory-system-definition-searcher))))

(when (probe-file #P"/Users/lispm/.local/share/ocicl/ocicl-runtime.lisp")
  (load #P"/Users/lispm/.local/share/ocicl/ocicl-runtime.lisp"))
