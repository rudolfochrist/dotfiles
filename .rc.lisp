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

(asdf:initialize-source-registry '(:source-registry :ignore-inherited-configuration))
(setf asdf:*system-definition-search-functions*
      (append asdf:*system-definition-search-functions*
              (list 'search-systems-in-current-directory-tree)))

;;; with-debug
;;; give me more details during development
#+sbcl
(progn
  ;; and make sure I keep more details during development.
  (sb-ext:restrict-compiler-policy 'safety 3)
  (sb-ext:restrict-compiler-policy 'debug 3)
  (sb-ext:restrict-compiler-policy 'space 3)
  (setf sb-impl::*default-external-format* :utf-8)
  ;; xref sbcl sources/contrib
  ;; see: https://github.com/Homebrew/homebrew-core/blob/master/Formula/s/sbcl.rb
  ;; adjusted for MacPorts.
  ;; Make sure to copy the src of sbcl manually to /opt/local/lib/sbcl
  (setf (logical-pathname-translations "SYS")
        '(("SYS:SRC;**;*.*.*" #p"/opt/local/lib/sbcl/src/**/*.*")
          ("SYS:CONTRIB;**;*.*.*" #p"/opt/local/lib/sbcl/contrib/**/*.*"))))
