

(setq gnus-thread-hide-subtree t)

(setq gnus-group-line-format "%M%S%4y: %(%g%)\n")
;; (setq gnus-topic-line-format "")

;; (setq gnus-topic-indent-level 4)
;; %1(%1{%4i %}%)%{ %}%2(%2{%7U %}%)%{ %}%3(%3{%7y %}%)%{%* %}%4(%B%-45G%)\n")

;; Try to reformat summary lines after we upgrade to 5.11
;;(setq gnus-summary-line-format "%U%R%z%I%(%[%4L: %-20,20n%]%) %s |%D\n")

 (setq gnus-summary-line-format ":%U%R %B %s %-40=|%4L |%-20,20f |%&user-date; \n")

(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

;;(setq gnus-agent t)

;; No HTML mail
    (setq mm-discouraged-alternatives '("text/html" "text/richtext"))


;; The following sets brad@chenla.org as the default,
;; and use brad@godown.sg from the projects folder.

(setq gnus-parameters
  ;;Use notthere id for all gmane news group postings
  '((".*"
     (posting-style
      (address "brad@chenla.la")
      (name "Brad Collins")
      (signature "Brad Collins <brad@chenla.la>\nskype|twitter: deerpig\nhttp://chenla.la")
      ;;(body "\n\n\n sivaram\n -- ")
      ;;(eval (setq message-sendmail-extra-arguments '("-a" "brad@chenla.la")))
      (user-mail-address "brad@chenla.la")
      ))
      ;;use anotherguy id for all normal mails
   (".*Repozit"
     (posting-style
      (address "deerpig@gmail.com")
      (name "Brad Collins")
      (signature "Brad Collins <brad@repozit.net>\nRepozit Storage Systyems - http://www.repozit.net")
      ;;(body "\n\n\n Sivaram A\n -- \n")
      ;;(eval (setq message-sendmail-extra-arguments '("-a" "brad@godown.org")))
      (user-mail-address "deerpig@gmail.com")
      ))

    (".*Cas.Nakamori"
     (posting-style
      (address "cas.nakamori@gmail.com")
      (name "Cassandra Nakamori")
      (signature "Cassandra Nakamori <cas.nakamori@gmail.com>\nSan Diego\nSkype: casnakamori Twitter: casnakamori")
      ;;(body "\n\n\n Sivaram A\n -- \n")
      ;;(eval (setq message-sendmail-extra-arguments '("-a" "brad@godown.org")))
      (user-mail-address "brad@godown.sg")
      ))
    ))

(setq smtpmail-debug-info t)

;; with Emacs 23.1, you have to set this explicitly (in MS Windows)
;; otherwise it tries to send through OS associated mail client
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq mail-user-agent 'gnus-user-agent)
;; we substitute sendmail with ssmtp
;; use with AuthSMTP
;; when you upgrade the OS:
;; yum install ssmtp
;; replace /etc/ssmtp/ssmtp.conf with copy in ~/emacs-lisp
;;
(setq sendmail-program "/usr/sbin/ssmtp")

(setq gnus-select-method '(nntp "nntp.aioe.org"))

;;(setq gnus-select-method '((nntp "csnews.cs.nctu.edu.tw")
;;                           (nntp "nntp.aioe.org")
;;			   ))


(add-to-list 'gnus-secondary-select-methods '(nnfolder ""))

;;(setq gnus-secondary-select-methods '((nntp "news.gmane.org")
 ;;                                     ))


(setq gnus-subscribe-newsgroup-method 'gnus-subscribe-topics)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode) ;; be sure using topics


(setq mail-sources '((file :path "/var/spool/mail/deerpig")))


;; Tell gnus which method to use for archives (nnfolder)
 (setq gnus-message-archive-method 
        '(nnfolder "archive"
 	 	  (nnfolder-directory   "~/mail/archive")
 		  (nnfolder-active-file "~/mail/active")
 		  (nnfolder-get-new-mail nil)
 		  (nnfolder-inhibit-expiry t)))
;; Tell gnus into which group to store messages
  (setq gnus-message-archive-group
        '((if (message-news-p)
  	     "misc-news"
  	   (concat "mail." (format-time-string "%Y-%m" (current-time))))))

;; Pull Some of the older headers when you open a group...

  (setq gnus-fetch-old-headers 'some)

;; archive messages M-x my-archive-article

(defun my-archive-article (&optional n)
  "Copies one or more article(s) to a corresponding `nnml:' group, e.g.
`gnus.ding' goes to `nnml:1.gnus.ding'. And `nnml:List-gnus.ding' goes
to `nnml:1.List-gnus-ding'.

Use process marks or mark a region in the summary buffer to archive
more then one article."
  (interactive "P")
  (let ((archive-name
         (format
          "nnml:1.%s"
          (if (featurep 'xemacs)
              (replace-in-string gnus-newsgroup-name "^.*:" "")
            (replace-regexp-in-string "^.*:" "" gnus-newsgroup-name)))))
    (gnus-summary-copy-article n archive-name)))

;; use only the first match.

(setq nnmail-crosspost nil)
(setq nnfolder-crosspost nil)

;; I don't want to see html mail unless I have to....

(eval-after-load "mm-decode"
      '(progn
           (add-to-list 'mm-discouraged-alternatives "text/html")
           (add-to-list 'mm-discouraged-alternatives "text/richtext")))

;; Don't split files

(setq message-send-mail-partially-limit nil)


;; Splitting Methods

(setq nnmail-split-methods
  '(("duplicates" "^Gnus-Warning:.*duplicate")
    ("Bounce" "^\\(From:\\).*[Pp]ostmaster@.*") ;; Bounce
    ("Spam" "^\\(From:\\).*mark zurlinton*.*")
    ("Spam" "^\\(From:\\).*zurlinton.mar89@gmail.com*.*")
    ("EmacsHelp" "^\\(To:\\|CC:\\).*help-gnu-emacs@*.*") 
    ("EmacsDevel" "^\\(To:\\|CC:\\).*emacs-devel@*.*") 
    ("EmacsDevel" "^\\(To:\\|CC:\\).*emacs-pretest-bug@gnu.org.*") 
    ("Org-Mode" "^\\(To:\\|CC:\\).*emacs-orgmode@gnu.org*.*") 
    ("XML-Dev" "^\\(To:\\|CC:\\).*xml-dev@lists.xml.org.*")
    ("Emacs-Sources" "^\\(To:\\|CC:\\).*gnu-emacs-sources@gnu.org.*")
    ("FriendsAndRelations" "^\\(From:\\).*Geojbc@aol.com")
    ("FriendsAndRelations" "^\\(From:\\).*geojbc@aol.com")
    ("FriendsAndRelations" "^\\(From:\\).*Ubudme@aol.com")
    ("FriendsAndRelations" "^\\(From:\\).*ubudme@aol.com") ;; Pa
    ("FriendsAndRelations" "^\\(From:\\).*kward@netvigator.com.*")
    ("FriendsAndRelations" "^\\(From:\\).*kaward@gmail.com.*")
    ("FriendsAndRelations" "^\\(From:\\).*kevinward@ernestmaude.com.*")
    ("FriendsAndRelations" "^\\(From:\\).*joli@net-yan.com")
    ("FriendsAndRelations" "^\\(From:\\).*meglomanious5@mac.com")
    ("FriendsAndRelations" "^\\(From:\\).*wikidown@yahoo.com")    ;; ruben
    ("FriendsAndRelations" "^\\(From:\\).*inter33usa@yahoo.com")  ;; ruben
    ("FriendsAndRelations" "^\\(From:\\).*rseja@4cpm.com")        ;; ruben
    ("FriendsAndRelations" "^\\(From:\\).*ruben@chenla.la")       ;; ruben
    ("FriendsAndRelations" "^\\(From:\\).*ruben@repozit.net")     ;; ruben
    ("FriendsAndRelations" "^\\(From:\\).*ruben@coreinterop.com") ;; ruben
    ("FriendsAndRelations" "^\\(From:\\).*osokuma@gmail.com")     ;; ruben
    ("FriendsAndRelations" "^\\(From:\\).*narin@repozit.net")     ;; narin
    ("FriendsAndRelations" "^\\(From:\\).*narin@chenla.la")       ;; narin    
    ("FriendsAndRelations" "^\\(From:\\).*evcolli@suffolk.lib.ny.us")
    ("FriendsAndRelations" "^\\(From:\\).*ecollins@aip.org")
    ("FriendsAndRelations" "^\\(From:\\).*bdeptola@gmail.com")    ;; ben
    ("FriendsAndRelations" "^\\(From:\\).*jefullerton@yahoo.com") ;; jon
    ("FriendsAndRelations" "^\\(From:\\Reply-To:\\).*liz.banbury@gmail.com")
    ("FriendsAndRelations" "^\\(From:\\).*tataj25@yahoo.com")       ;; Da
    ("FriendsAndRelations" "^\\(From:\\).*boblq@cox.net")           ;; Bob
    ("FriendsAndRelations" "^\\(From:\\).*rlaquey@gmail.com")       ;; Bob
    ("FriendsAndRelations" "^\\(From:\\).*robert.laquey@gmail.com") ;; Bob
    ("FriendsAndRelations" "^\\(From:\\).*jolicollins@yahoo.com.hk") ;; Jo
    ("FriendsAndRelations" "^\\(From:\\).*spitfire@san.rr.com")      ;; Jeff
    ("FriendsAndRelations" "^\\(From:\\).*spitfireroad@gmail.com")   ;; Jeff  
    ("FriendsAndRelations" "^\\(From:\\).*mucci625@mac.com.*")       ;; Mucci
    ("FriendsAndRelations" "^\\(From:\\).*peacebrother@gmail.com.*") ;; Derek
    ("FriendsAndRelations" "^\\(From:\\).*cmkzone@yahoo.com.au.*")   ;; Craig
    ("FriendsAndRelations" "^\\(From:\\).*harper.paul.j@gmail.com.*") ;; Paul H
    ("Work" "^\\(From:\\).*jjordan@janicejordan.org.*")          ;; Janice
    ("Work" "^\\(From:\\).*barryl@san.rr.com.*")                 ;; Barry
    ("Work" "^\\(From:\\).*larry@kumeyaay.com.*")                ;; Larry
    ("Work" "^\\(From:\\).*dirkholland@prodigy.net.*") ;;
    ("Work" "^\\(From:\\).*jharaejordananderson@yahoo.com.*") ;; Jharae
    ("Work" "^\\(From:\\).*Hunwut@aol.com.*") ;;
    ("Work" "^\\(From:\\).*james@host45.com.*") ;; James (host45)
    ("Work" "^\\(From:\\).*mati@host45.com.*") ;; Mati (host45)
    ("Work" "^\\(From:\\).*kalvarez@mortgageonelending.com.*") ;; Kevin Alvarez
    ("Work" "^\\(From:\\).*dmelton@indiangaming.org.*") ;; Dana Melton
    ("Work" "^\\(From:\\).*jalonz@coldworld.net.*") ;; Jalon
    ("Work" "^\\(From:\\).*info@aquaresidential.com.*") ;; Kevin  Alvarez
    ("Work" "^\\(From:\\).*dcchan8@gmail.com.*") ;; DC Chan
    ("Work" "^\\(From:\\).*dbear@archimuse.com.*") ;; David Bearman
    ("Work" "^\\(From:\\).*amolina@indiangaming.org.*") ;; Angelica Molina
    ("Work" "^\\(From:\\).*dmelton@indiangaming.org.*") ;; Dana Melton
    ("Work" "^\\(From:\\).*chris@datacoordinator.com.*") ;; Chris Coddington
    ("Work" "^\\(From:\\).*mmueller@indylink.org.*") ;; Mark Mueller
    ("Arxana" "^\\(To:\\|From:\\|CC:\\).*arxana-talk@googlegroups.com*")
    ("Work" "^\\(From:\\).*holtzermann17@gmail.com.*") ;; Joe Corneli
    ("Chenla" "^\\(From:\\).*j.ottaway@lse.ac.uk.*")
    ("Chenla" "^\\(From:\\).*news@pglaf.org.*")
    ("Interesting-people" "^\\(To:\\|CC:\\).*ip@v2.listbox.com.*")
    ("Interesting-people" "^\\(From:\\).*dave@farber.net.*")
    ("Interesting-people" "^\\(From:\\|Reply-To:\\).*dave@farber.net.*")
    ("Chenla" "^\\(To:\\|From:\\).*chenla-dev@googlegroups.com.*")
    ("Chenla" "^\\(To:\\|From:\\).*chenla-talk@googlegroups.com.*")
    ("Scheme" "^\\(To:\\|From:\\|CC:\\).*plt-scheme@list.cs.brown.edu.*")
    ("Scheme" "^\\(To:\\|From:\\|CC:\\).*users@racket-lang.org.*")
    ("Twitter" "^\\(To:\\|From:\\|CC:\\).*twitter.com.*")
    ("Twitter" "^\\(To:\\|From:\\|CC:\\).*identi.ca.*")
    ("FromIPod" "^\\(From:\\).*deerpig@gmail.com*")
    ("Cas Nakamori" "^\\(To:\\|From:\\|CC:\\).*cas.nakamori@gmail.com*")
    ("Domains" "^\\(To:\\|From:\\|CC:\\).*directnic.com*")
    ("Domains" "^\\(To:\\|From:\\|CC:\\).*marcaria.com*")
    ("Domains" "^\\(To:\\|From:\\|CC:\\).*nic.io*")
    ("Repozit" "^\\(To:\\|From:\\|CC:\\).*djroberts99@cox.net*")
    ("Pathmazing" "^\\(To:\\|From:\\|CC:\\).*pathmazing.com*")
    ;; archival groups
    ("CouchDB" "^\\(To:\\|From:\\|CC:\\).*dev@couchdb.apache.org*")
    ("Cryptography" "^\\(To:\\|From:\\|CC:\\).*cryptography@metzdowd.com*")
    ("2000" "^\\(Date:\\).* 2000 *")
    ("2001" "^\\(Date:\\).* 2001 *")
    ("2002" "^\\(Date:\\).* 2002 *")
    ("2003" "^\\(Date:\\).* 2003 *")
    ("2004" "^\\(Date:\\).* 2004 *")
    ("2005" "^\\(Date:\\).* 2005 *")
    ("2006" "^\\(Date:\\).* 2006 *")
    ("2007" "^\\(Date:\\).* 2007 *")
    ("2008" "^\\(Date:\\).* 2008 *")
    ("2009" "^\\(Date:\\).* 2009 *")
    ("2010" "^\\(Date:\\).* 2010 *")
    ("2011" "^\\(Date:\\).* 2011 *")
    ("2012" "^\\(Date:\\).* 2012 *")
    ("2013" "^\\(Date:\\).* 2013 *")
    ("2014" "^\\(Date:\\).* 2014 *")
    ("2015" "^\\(Date:\\).* 2015 *")
    ;;("2016" "^\\(Date:\\).* 2016 *")
    ;;("2017" "^\\(Date:\\).* 2017 *")
    ;;("2018" "^\\(Date:\\).* 2018 *")
    ;;("2019" "^\\(Date:\\).* 2019 *")
    ;;("2020" "^\\(Date:\\).* 2020 *")
    ("Inbox" "")))

(require 'nnir)

;; (setq gnus-secondary-select-methods
;;       '((nnml "bulma"
;;          (nnimap-address "localhost")
;;          (nnir-search-engine namazu))))

(setq nnir-search-engine 'namazu)
(setq nnir-namazu-index-directory (expand-file-name "/home/deerpig/.namazu-mail"))
;; remove-prefix requires trail /
(setq nnir-namazu-remove-prefix (expand-file-name "/home/deerpig/Mail/"))
(setq nnir-mail-backend gnus-select-method)
(setq gnus-namazu-index-update-interval nil)
(setq nnir-mail-backend (nth 0 gnus-secondary-select-methods))
