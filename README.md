Welcome Darts-Log
=================

Darts Log can handle Maillog-files from mails sent by
[Russ Bray Darts Scorer - Application](http://itunes.apple.com/de/app/russ-bray-s-scorer/id377453562?mt=8).

darts.iboard.cc
===============

Upload by email (the easy way)
------------------------------

  You can send your scores to darts@iboard.cc and then view your table
  at http://darts.iboard.cc.

Upload maildir-files (Batch-Upload)
-----------------------------------

  1. Send mails from the app to your e-mail-account
  1. Mark all Mails from the app and chose
    1. Save As (Raw Mail-format)
    1. Name the file 'results.txt'
  1. Visit http://darts.iboard.cc and upload your file
  1. View a nice formated HTML-Table
  1. Download your data as CSV-Table to use with your spreadsheet-app.

Your own server
===============

Feel free to fork or clone this rails-application from [github.com/iboard/Darts-Log](http://github.com/iboard/Darts-Log).

  1. Copy _config/mailconfig.rb_sample_ to _config/mainconfig.rb_ and edit to fit your needs.
  2. Start the Mailfetch-process with `script/mail_reader.rb`
    * You may start this process with your production-server from within `/etc/inittab`


Contact
=======
  
_darts@iboard.cc_ will process all mails formated as by Ross Bray's Scorer.
All other mails will be dropped and not get readed!
  
To contact me, please mail to andreas-at-altendorfer.at or use [Github-issues](http://github.com/iboard/Darts-Log/issues) to report any issues.

Darts-Log is licensed under the terms of
========================================

* [The MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2011 Andreas Altendorfer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE SOFTWARE.
