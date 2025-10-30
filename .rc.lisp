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
(require 'asdf)
#+sbcl (require 'sb-aclrepl)

(setf *print-level* 50)
(setf *print-length* 200)

;;; Configure ASDF source registry from $PWD tree
(defun search-systems-in-current-directory-tree (system-name)
  (dolist (asd (uiop:directory-files (uiop:getcwd) "**/*.asd"))
    (when (string= (pathname-name asd) system-name)
      (return asd))))

#+asdf
(progn
  (asdf:initialize-source-registry '(:source-registry :ignore-inherited-configuration))
  (setf asdf:*system-definition-search-functions*
        (append asdf:*system-definition-search-functions*
                (list 'search-systems-in-current-directory-tree))))

;;; with-debug
;;; give me more details during development
#+sbcl
(progn
  (setf sb-impl::*default-external-format* :utf-8)
  ;; and make sure I keep more details during development.
  (sb-ext:restrict-compiler-policy 'safety 3)
  (sb-ext:restrict-compiler-policy 'debug 3)
  (sb-ext:restrict-compiler-policy 'space 1 1)
  (sb-ext:restrict-compiler-policy 'speed 1 1))
