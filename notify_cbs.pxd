#
#  Copyright (c) 2008 INdT - Instituto Nokia de Tecnologia
#
#  This file is part of python-purple.
#
#  python-purple is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  python-purple is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

cimport purple

cdef extern from *:
    ctypedef char const_char "const char"
    ctypedef int size_t

notify_cbs = {}

cdef void *notify_message(notify.PurpleNotifyMsgType type, \
        const_char *title, const_char *primary, const_char *secondary):
    """
    TODO
    """
    debug.c_purple_debug_info("notify", "%s", "notify-message\n")
    if notify_cbs.has_key("notif-message"):
        (<object> notify_cbs["notify-message"])("notify-message: TODO")

cdef void *notify_email(connection.PurpleConnection *gc, \
        const_char *subject, const_char *_from, const_char *to, \
        const_char *url):
    """
    TODO
    """
    debug.c_purple_debug_info("notify", "%s", "notify-email\n")
    if notify_cbs.has_key("notify-email"):
        (<object> notify_cbs["notify-email"])("notify-email: TODO")

cdef void *notify_emails(connection.PurpleConnection *gc, size_t count, \
        glib.gboolean detailed, const_char **subjects, \
        const_char **froms, const_char **tos, const_char **urls):
    """
    TODO
    """
    debug.c_purple_debug_info("notify", "%s", "notify-emails\n")
    if notify_cbs.has_key("notify-emails"):
        (<object> notify_cbs["notify-emails"])("notify-emails: TODO")

cdef void *notify_formatted(const_char *title, const_char *primary, \
        const_char *secondary, const_char *text):
    """
    TODO
    """
    debug.c_purple_debug_info("notify", "%s", "notify-formatted\n")
    if notify_cbs.has_key("notify-formatted"):
        (<object> notify_cbs["notify-formatted"])("notify-formatted: TODO")

cdef void *notify_searchresults(connection.PurpleConnection *gc, \
        const_char *title, const_char *primary, const_char *secondary, \
        notify.PurpleNotifySearchResults *results, glib.gpointer user_data):
    """
    TODO
    """
    debug.c_purple_debug_info("notify", "%s", "notify-searchresults\n")
    if notify_cbs.has_key("notify-searchresults"):
        (<object> notify_cbs["notify-searchresults"])("notify-searchresults: TODO")

cdef void notify_searchresults_new_rows(connection.PurpleConnection *gc, \
        notify.PurpleNotifySearchResults *results, void *data):
    """
    TODO
    """
    debug.c_purple_debug_info("notify", "%s", "notify-searchresults-new-rows\n")
    if notify_cbs.has_key("notify-searchresults-new-rows"):
        (<object> notify_cbs["notify-searchresults-new-rows"])("notify-searchresults-new-rows: TODO")

cdef void *notify_userinfo(connection.PurpleConnection *gc, const_char *who, \
        notify.PurpleNotifyUserInfo *user_info):
    """
    TODO
    """
    debug.c_purple_debug_info("notify", "%s", "notify-userinfo\n")
    if notify_cbs.has_key("notify-userinfo"):
        (<object> notify_cbs["notify-userinfo"])("notify-userinfo: TODO")

cdef void *notify_uri(const_char *uri):
    """
    TODO
    """
    debug.c_purple_debug_info("notify", "%s", "notify-uri\n")
    if notify_cbs.has_key("notify-uri"):
        (<object> notify_cbs["notify-uri"])("notify-uri: TODO")

cdef void close_notify(notify.PurpleNotifyType type, void *ui_handle):
    """
    TODO
    """
    debug.c_purple_debug_info("notify", "%s", "close-notify\n")
    if notify_cbs.has_key("close-notify"):
        (<object> notify_cbs["close-notify"])("close-notify: TODO")
