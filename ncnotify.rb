# Author: Takahiro Yoshihara
# Email: tacahiroy@gmail.com
# Homepage:
# Version: 0.0.1
# License: GPL3
# Depends on terminal-notifier (https://github.com/alloy/terminal-notifier)

# This program is based on gntp-notify written by Justin Anderson (jandersonis@gmail.com)
# https://github.com/tinifni/gntp-notify

require "rubygems"
require "terminal-notifier"

def weechat_init
  Weechat.register("ncnotify",
                   "Takahiro Yoshihara",
                   "0.0.1",
                   "GPL3",
                   "Pass highlights and private messages to the OS X 10.8+ Notification Center",
                   "",
                   ""
  )

  hook_notifications

  return Weechat::WEECHAT_RC_OK
end

def hook_notifications
  Weechat.hook_signal("weechat_pv", "show_private", "")
  Weechat.hook_signal("weechat_highlight", "show_highlight", "")
end

def unhook_notifications(data, signal, message)
  Weechat.unhook(show_private)
  Weechat.unhook(show_highlight)
end

def notify(title, subtitle, message)
  TerminalNotifier.notify(message, :title => title, :subtitle => subtitle, :group => Process.pid)
end

def show_private(data, signal, message)
  show_notification("Private", "Weechat Private Message",  message)
  return Weechat::WEECHAT_RC_OK
end

def show_highlight(data, signal, message)
  show_notification("Highlight", "Weechat",  message)
  return Weechat::WEECHAT_RC_OK
end

def show_notification(title, subtitle, message)
  TerminalNotifier.notify(message, :title => title, :subtitle => subtitle, :group => Process.pid)
end
