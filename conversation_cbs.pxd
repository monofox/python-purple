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
    ctypedef glib.guchar const_guchar "const guchar"
    ctypedef long int time_t

conversation_cbs = {}

cdef void create_conversation(conversation.PurpleConversation *conv):
    """
    Called when a conv is created (but before the conversation-created
    signal is emitted).
    """
    debug.c_purple_debug_info("conversation", "%s", "create-conversation\n")
    cdef char *c_name = NULL

    c_name = <char *> conversation.c_purple_conversation_get_name(conv)
    if c_name == NULL:
        name = None
    else:
        name = c_name

    type = conversation.c_purple_conversation_get_type(conv)

    if conversation_cbs.has_key("create-conversation"):
        (<object> conversation_cbs["create-conversation"])(name, type)

cdef void destroy_conversation(conversation.PurpleConversation *conv):
    """
    Called just before a conv is freed.
    """
    debug.c_purple_debug_info("conversation", "%s", "destroy-conversation\n")
    if conversation_cbs.has_key("destroy-conversation"):
        (<object> conversation_cbs["destroy-conversation"])("destroy-conversation: TODO")

cdef void write_chat(conversation.PurpleConversation *conv, const_char *who, \
        const_char *message, conversation.PurpleMessageFlags flags, \
        time_t mtime):
    """
    Write a message to a chat. If this field is NULL, libpurple will fall
    back to using write_conv.
    @see purple_conv_chat_write()
    """
    debug.c_purple_debug_info("conversation", "%s", "write-chat\n")
    if conversation_cbs.has_key("write-chat"):
        (<object> conversation_cbs["write-chat"])("write-chat: TODO")

cdef void write_im(conversation.PurpleConversation *conv, const_char *who, \
        const_char *c_message, conversation.PurpleMessageFlags flags, \
        time_t mtime):
    """
    Write a message to an IM conversation. If this field is NULL, libpurple
    will fall back to using write_conv.
    @see purple_conv_im_write()
    """
    debug.c_purple_debug_info("conversation", "%s", "write-im\n")
    cdef account.PurpleAccount *acc = conversation.c_purple_conversation_get_account(conv)
    cdef blist.PurpleBuddy *buddy = NULL
    cdef char *c_username = NULL
    cdef char *c_sender_alias = NULL

    c_username = <char *> account.purple_account_get_username(acc)
    if c_username:
        username = c_username
    else:
        username = None

    if who:
        sender = <char *> who
        buddy = blist.c_purple_find_buddy(acc, <char *> who)
        c_sender_alias = <char *> blist.c_purple_buddy_get_alias_only(buddy)
    else:
        sender = None

    if c_sender_alias:
        sender_alias = c_sender_alias
    else:
        sender_alias = None

    if c_message:
        message = <char *> c_message
    else:
        message = None

    if conversation_cbs.has_key("write-im"):
        (<object> conversation_cbs["write-im"])(username, sender, \
                                                sender_alias, message)

cdef void write_conv(conversation.PurpleConversation *conv, const_char *name, \
        const_char *alias, const_char *message, \
        conversation.PurpleMessageFlags flags, time_t mtime):
    """
    Write a message to a conversation. This is used rather than the chat- or
    im-specific ops for errors, system messages (such as "x is now known as
    y"), and as the fallback if write_im and write_chat are not implemented.
    It should be implemented, or the UI will miss conversation error messages
    and your users will hate you.
    @see purple_conversation_write()
    """
    debug.c_purple_debug_info("conversation", "%s", "write-conv\n")
    if conversation_cbs.has_key("write-conv"):
        (<object> conversation_cbs["write-conv"])("write-conv: TODO")

cdef void chat_add_users(conversation.PurpleConversation *conv, \
        glib.GList *cbuddies, glib.gboolean new_arrivals):
    """
    Add cbuddies to a chat.
    @param cbuddies  A GList of PurpleConvChatBuddy structs.
    @param new_arrivals  Wheter join notices should be shown.
                         (Join notices are actually written to the
                         conversation by purple_conv_chat_add_users().)
    @see purple_conv_chat_add_users()
    """
    debug.c_purple_debug_info("conversation", "%s", "chat-add-users\n")
    if conversation_cbs.has_key("chat-add-users"):
        (<object> conversation_cbs["chat-add-users"])("chat-add-users: TODO")

cdef void chat_rename_user(conversation.PurpleConversation *conv, \
        const_char *old_name, const_char *new_name,
        const_char *new_alias):
    """
    Rename the user in this chat name old_name to new_name. (The rename
    message is written to the conversation by libpurple.)
    @param new_alias  new_name's new_alias, if they have one.
    @see purple_conv_chat_rename_user()
    """
    debug.c_purple_debug_info("conversation", "%s", "chat-rename-user\n")
    if conversation_cbs.has_key("chat-rename-user"):
        (<object> conversation_cbs["chat-rename-user"])("chat-rename-user: TODO")

cdef void chat_remove_users(conversation.PurpleConversation *conv, \
        glib.GList *users):
    """
    Remove users from a chat.
    @param  users  A GList of const char *s.
    """
    debug.c_purple_debug_info("conversation", "%s", "chat-remove-users\n")
    if conversation_cbs.has_key("chat-remove-users"):
        (<object> conversation_cbs["chat-remove-users"])("chat-remove-users: TODO")

cdef void chat_update_user(conversation.PurpleConversation *conv, \
        const_char *user):
    """
    Called when a user's flags are changed.
    @see purple_conv_chat_user_set_flags()
    """
    debug.c_purple_debug_info("conversation", "%s", "chat-update-user\n")
    if conversation_cbs.has_key("chat-update-user"):
        (<object> conversation_cbs["chat-update-user"])("chat-update-user: TODO")

cdef void present(conversation.PurpleConversation *conv):
    """
    Present this conversation to the user; for example, by displaying the IM
    dialog.
    """
    debug.c_purple_debug_info("conversation", "%s", "present\n")
    if conversation_cbs.has_key("present"):
        (<object> conversation_cbs["present"])("present: TODO")

cdef glib.gboolean has_focus(conversation.PurpleConversation *conv):
    """
    If this UI has a concept of focus (as in a windowing system) and this
    conversation has the focus, return TRUE; otherwise, return FALSE.
    """
    debug.c_purple_debug_info("conversation", "%s", "has-focus\n")
    if conversation_cbs.has_key("has-focus"):
        (<object> conversation_cbs["has-focus"])("has-focus: TODO")
    return False

cdef glib.gboolean custom_smiley_add(conversation.PurpleConversation *conv, \
        const_char *smile, glib.gboolean remote):
    """
    Custom smileys (add).
    """
    debug.c_purple_debug_info("conversation", "%s", "custom-smiley-add\n")
    if conversation_cbs.has_key("custom-smiley-add"):
        (<object> conversation_cbs["custom-smiley-add"])("custom-smiley-add: TODO")
    return False

cdef void custom_smiley_write(conversation.PurpleConversation *conv, \
        const_char *smile, const_guchar *data, glib.gsize size):
    """
    Custom smileys (write).
    """
    debug.c_purple_debug_info("conversation", "%s", "custom-smiley-write\n")
    if conversation_cbs.has_key("custom-smiley-write"):
        (<object> conversation_cbs["custom-smiley-write"])("custom-smiley-write: TODO")

cdef void custom_smiley_close(conversation.PurpleConversation *conv, \
        const_char *smile):
    """
    Custom smileys (close).
    """
    debug.c_purple_debug_info("conversation", "%s", "custom-smiley-close\n")
    if conversation_cbs.has_key("custom-smiley-close"):
        (<object> conversation_cbs["custom-smiley-close"])("custom-smiley-close: TODO")

cdef void send_confirm(conversation.PurpleConversation *conv, \
        const_char *message):
    """
    Prompt the user for confirmation to send mesage. This function should
    arrange for the message to be sent if the user accepts. If this field
    is NULL, libpurple will fall back to using purple_request_action().
    """
    debug.c_purple_debug_info("conversation", "%s", "send-confirm\n")
    if conversation_cbs.has_key("send-confirm"):
        (<object> conversation_cbs["send-confirm"])("send-confirm: TODO")
