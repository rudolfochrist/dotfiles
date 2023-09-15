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
(proclaim '(optimize (speed 0) (compilation-speed 0) (safety 3) (debug 3)))

#+sbcl
(progn
  ;; and make sure I keep more details during development.
  (sb-ext:restrict-compiler-policy 'safety 3)
  (sb-ext:restrict-compiler-policy 'debug 3)
  (setf sb-impl::*default-external-format* :utf-8))

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
  (setf asdf:*system-definition-search-functions*
        (append asdf:*system-definition-search-functions*
                (list 'current-directory-system-definition-searcher))))

#-ocicl
(when (probe-file #P"/Users/lispm/.local/share/ocicl/ocicl-runtime.lisp")
  (load #P"/Users/lispm/.local/share/ocicl/ocicl-runtime.lisp")
  ;; Any systems you install in /Users/lispm/.local/share/ocicl/
  ;; will be available globally unless you comment out this line:
  (asdf:initialize-source-registry
   '(:source-registry
     :ignore-inherited-configuration
     (:tree #P"/Users/lispm/.local/share/ocicl/"))))
