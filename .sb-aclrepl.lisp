;;; Init SBCL ACL REPL

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

;;; This is super hackish.
(let ((cmd (sb-aclrepl::find-cmd "exit")))
  (setf (sb-aclrepl::cmd-table-entry-func cmd) #'ovwrt-exit-cmd)
  (sb-aclrepl::%add-entry
   cmd
   (sb-aclrepl::cmd-table-entry-abbr-len cmd)))

#+quicklisp
(sb-aclrepl:alias ("ql" 1 "quickload system") (system)
                  (ql:quickload system))
#+asdf
(sb-aclrepl:alias ("make" 1 "asdf:make system") (system)
                  (asdf:make system))
