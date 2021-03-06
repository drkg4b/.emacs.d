;;; package --- Summary
;;; Commentary:
;;; Code:

(add-to-list 'load-path "/usr/share/emacs24/site-lisp/mu4e/")
(require 'mu4e)
(require 'org-mu4e)

;; reply attribution line
(setq message-citation-line-format "On %a, %b %d %Y, %N wrote:")
(setq message-citation-line-function 'message-insert-formatted-citation-line)


;; My email addresses
(setq mu4e-user-mail-address-list '("gab.bertoli@gmail.com"
				    "gabriele.bertoli@fysik.su.se"
				    "gbertoli@cern.ch"
				    "gabriele.bertoli@cern.ch"
				    "drkg4b@alice.it"))

;; General Settings
(setq
 mail-user-agent 'mu4e-user-agent       ;mu4e as default user agent
 mu4e-view-show-images t                ;enable inline images
 mu4e-compose-dont-reply-to-self t      ;don't reply to me when replying to a mail
 mu4e-get-mail-command "mbsync -a"      ;fetch mail
 mu4e-update-interval 300               ;update every 5 minutes
 mu4e-headers-skip-duplicates t         ;skip duplicate email, great for gmail
 ;mu4e-compose-complete-only-personal t ;only personal messages get in the address book
 message-kill-buffer-on-exit t          ;don't keep message buffers around
 smtpmail-queue-mail nil                ;don't queue messages before sending
 mu4e-html2text-command "html2text -utf8 -width 72" ;use html2text program
 mu4e-msg2pdf "/usr/bin/msg2pdf"       ;specify the path for msg2pdf
 ;; mu4e-headers-include-related t ; This enabled the thread like viewing of email similar to gmail's UI.
 mu4e-attachment-dir "~/Downloads/attachments"
 )

;; Display a New Mail message in the kdialog on new mails
(add-hook 'mu4e-index-updated-hook
	  (defun new-mail-notification ()
	    ;; (shell-command "if [[ -n $(mu find flag:new) ]]; then kdialog --passivepopup \"New Mail on $(date)\" 5; fi")))
	    (shell-command "/home/drkg4b/.count_new_emails.sh")))

;; Add bookmark
(add-to-list 'mu4e-bookmarks
	     '("flag:flagged" "Flagged Messages" ?f))

;; Maildir location
(setq mu4e-maildir "/home/drkg4b/.mail")

;; add some composing hooks
(add-hook 'mu4e-compose-mode-hook
	  (defun my-do-compose-stuff ()
	    "My settings for message composition."
	    (set-fill-column 80)
	    (flyspell-mode)))

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; to see messages in browser, type aV
(add-to-list 'mu4e-view-actions
	     '("ViewInBrowser" . mu4e-action-view-in-browser) t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; attach files with dired, mark them and then type C-c RET C-a
(require 'gnus-dired)
;; make the `gnus-dired-mail-buffers' function also work on
;; message-mode derived modes, such as mu4e-compose-mode
(defun gnus-dired-mail-buffers ()
  "Return a list of active message buffers."
  (let (buffers)
    (save-current-buffer
      (dolist (buffer (buffer-list t))
     	(set-buffer buffer)
     	(when (and (derived-mode-p 'message-mode)
		   (null message-sent-message-via))
     	  (push (buffer-name buffer) buffers))))
    (nreverse buffers)))

(setq gnus-dired-mail-mode 'mu4e-user-agent)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
	  (if mu4e-compose-parent-message
	      (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
		(string-match "/\\(.*?\\)/" maildir)
		(match-string 1 maildir))
	    (completing-read (format "Compose with account: (%s) "
				     (mapconcat #'(lambda (var) (car var)) my-mu4e-account-alist "/"))
			     (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
			     nil t nil nil (caar my-mu4e-account-alist))))
	 (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
	(mapc #'(lambda (var)
		  (set (car var) (cadr var)))
	      account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun file-string (file)
  "Read the contents of a file and return as a string."
  (with-current-buffer (find-file-noselect file)
    (buffer-string)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; something about ourselves
(setq
 user-mail-address "gab.bertoli@gmail.com"
 mu4e-compose-signature "/home/drkg4b/.signature")
;; message-signature-file "/home/drkg4b/.signature")

;; Use msmtp to send mails
(setq message-send-mail-function 'message-send-mail-with-sendmail
	sendmail-program "/usr/bin/msmtp"
	user-full-name "Gabriele Bertoli")

;; (require 'smtpmail)

;; (setq
;;  message-send-mail-function 'smtpmail-send-it
;;  smtpmail-stream-type 'starttls
;;  smtpmail-default-smtp-server "smtp.gmail.com"
;;  smtpmail-smtp-server "smtp.gmail.com"
;;  smtpmail-smtp-service 587)

(defvar my-mu4e-account-alist
  '(("gmail"
    (mu4e-drafts-folder "/gmail/INBOX")
    (mu4e-sent-folder   "/gmail/INBOX")
    (mu4e-trash-folder  "/gmail/INBOX")
    (user-mail-address "gab.bertoli@gmail.com")
    (mu4e-compose-signature (file-string "/home/drkg4b/.signature"))
    ;; (message-signature-file "/home/drkg4b/.signature")
    ;; (smtpmail-default-smtp-server "smtp.gmail.com")
    ;; (smtpmail-local-domain "gmail.com")
    ;; (smtpmail-smtp-server "smtp.gmail.com")
    ;; (smtpmail-smtp-service 587)
    )
    ("su"
     (mu4e-sent-folder "/su/Skickat")
     (mu4e-drafts-folder "/su/Utkast")
     (mu4e-trash-folder "/su/Borttaget")
     (user-mail-address "gabriele.bertoli@fysik.su.se")
     (mu4e-compose-signature (file-string "/home/drkg4b/.signature_stockholm"))
     ;; (message-signature-file "/home/drkg4b/.signature_stockholm")
     ;; (smtpmail-default-smtp-server "smtp.su.se")
     ;; (smtpmail-local-domain "fysik.su.se")
     ;; (smtpmail-smtp-server "smtp.su.se")
     ;; (smtpmail-stream-type starttls)
     ;; (smtpmail-smtp-service 587)
     )
    ("cern"
     (mu4e-sent-folder "/cern/Sent")
     (mu4e-drafts-folder "/cern/Drafts")
     (mu4e-trash-folder "/cern/Trash")
     (user-mail-address "gbertoli@cern.ch")
     (mu4e-compose-signature (file-string "/home/drkg4b/.signature_stockholm"))
     ;; (message-signature-file "/home/drkg4b/.signature_stockholm")
     ;; (smtpmail-default-smtp-server "smtp.cern.ch")
     ;; (smtpmail-local-domain "cern.ch")
     ;; (smtpmail-smtp-server "smtp.cern.ch")
     ;; (smtpmail-stream-type starttls)
     ;; (smtpmail-smtp-service 587)
     )
    ("alice"
     (mu4e-sent-folder "/Alice/Posta inviata")
     (mu4e-drafts-folder "/Alice/Bozze")
     (mu4e-trash-folder "/Alice/Trash")
     (user-mail-address "drkg4b@alice.it")
     (mu4e-compose-signature (file-string "/home/drkg4b/.signature"))
     ;; (message-signature-file "/home/drkg4b/.signature")
     ;; (smtpmail-default-smtp-server "out.alice.it")
     ;; (smtpmail-local-domain "alice.it")
     ;; (smtpmail-smtp-server "out.alice.it")
     ;; (smtpmail-stream-type nil)
     ;; (smtpmail-smtp-service 587)
     )))

(provide 'mu4e-settings.el)
;;; mu4e-settings.el ends here
