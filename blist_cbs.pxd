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

blist_cbs = {}

cdef void __group_node_cb(blist.PurpleBlistNode *node, object callback):
    cdef blist.PurpleGroup *group = <blist.PurpleGroup *>node
    cdef char *c_name = NULL

    c_name = <char *> blist.purple_group_get_name(group)
    if c_name == NULL:
        name = None
    else:
        name = c_name

    currentsize = blist.purple_blist_get_group_size(group, False)
    totalsize = blist.purple_blist_get_group_size(group, True)
    online = blist.purple_blist_get_group_online_count(group)

    callback(node.type, name, totalsize, currentsize, online)

cdef void __contact_node_cb(blist.PurpleBlistNode *node, object callback):
    cdef blist.PurpleContact *contact = <blist.PurpleContact *>node
    cdef char *c_alias = NULL

    c_alias = <char *> blist.purple_contact_get_alias(contact)
    if c_alias == NULL:
        alias = None
    else:
        alias = c_alias

    callback(node.type, alias, contact.totalsize, contact.currentsize, \
             contact.online)

cdef void __buddy_node_cb(blist.PurpleBlistNode *node, object callback):
    cdef blist.PurpleBuddy *buddy = <blist.PurpleBuddy *>node
    cdef char *c_name = NULL
    cdef char *c_alias = NULL

    c_name = <char *> blist.purple_buddy_get_name(buddy)
    if c_name == NULL:
        name = None
    else:
        name = c_name

    c_alias = <char *> blist.purple_buddy_get_alias_only(buddy)
    if c_alias == NULL:
        alias = None
    else:
        alias = c_alias

    callback(node.type, name, alias)

cdef void __chat_node_cb(blist.PurpleBlistNode *node, object callback):
    cdef blist.PurpleChat *chat = <blist.PurpleChat *>node
    cdef char *c_name = NULL

    c_name = <char *> blist.purple_chat_get_name(chat)
    if c_name == NULL:
        name = None
    else:
        name = c_name

    callback(node.type, name)

cdef void __other_node_cb(blist.PurpleBlistNode *node, object callback):
    callback(node.type)

cdef void new_list(blist.PurpleBuddyList *list):
    """
    Sets UI-specific data on a buddy list.
    """
    debug.purple_debug_info("blist", "%s", "new-list\n")
    if blist_cbs.has_key("new-list"):
        (<object> blist_cbs["new-list"])("new-list: TODO")

cdef void new_node(blist.PurpleBlistNode *node):
    """
    Sets UI-specific data on a node.
    """
    debug.purple_debug_info("blist", "%s", "new-node\n")
    if blist_cbs.has_key("new-node"):
        if node.type == blist.PURPLE_BLIST_GROUP_NODE:
            __group_node_cb(node, blist_cbs["new-node"])
        elif node.type == blist.PURPLE_BLIST_CONTACT_NODE:
            __contact_node_cb(node, blist_cbs["new-node"])
        elif node.type == blist.PURPLE_BLIST_BUDDY_NODE:
            __buddy_node_cb(node, blist_cbs["new-node"])
        elif node.type == blist.PURPLE_BLIST_CHAT_NODE:
            __chat_node_cb(node, blist_cbs["new-node"])
        elif node.type == blist.PURPLE_BLIST_OTHER_NODE:
            __other_node_cb(node, blist_cbs["new-node"])

cdef void show(blist.PurpleBuddyList *list):
    """
    The core will call this when it's finished doing its core stuff.
    """
    debug.purple_debug_info("blist", "%s", "show\n")
    if blist_cbs.has_key("show"):
        (<object> blist_cbs["show"])("show: TODO")

cdef void update(blist.PurpleBuddyList *list, blist.PurpleBlistNode *node):
    """
    This will update a node in the buddy list.
    """
    debug.purple_debug_info("blist", "%s", "update\n")
    if blist_cbs.has_key("update"):
        if node.type == blist.PURPLE_BLIST_GROUP_NODE:
            __group_node_cb(node, blist_cbs["update"])
        elif node.type == blist.PURPLE_BLIST_CONTACT_NODE:
            __contact_node_cb(node, blist_cbs["update"])
        elif node.type == blist.PURPLE_BLIST_BUDDY_NODE:
            __buddy_node_cb(node, blist_cbs["update"])
        elif node.type == blist.PURPLE_BLIST_CHAT_NODE:
            __chat_node_cb(node, blist_cbs["update"])
        elif node.type == blist.PURPLE_BLIST_OTHER_NODE:
            __other_node_cb(node, blist_cbs["update"])

cdef void remove(blist.PurpleBuddyList *list, blist.PurpleBlistNode *node):
    """
    This removes a node from the list.
    """
    debug.purple_debug_info("blist", "%s", "remove\n")
    if blist_cbs.has_key("remove"):
        if node.type == blist.PURPLE_BLIST_GROUP_NODE:
            __group_node_cb(node, blist_cbs["remove"])
        elif node.type == blist.PURPLE_BLIST_CONTACT_NODE:
            __contact_node_cb(node, blist_cbs["remove"])
        elif node.type == blist.PURPLE_BLIST_BUDDY_NODE:
            __buddy_node_cb(node, blist_cbs["remove"])
        elif node.type == blist.PURPLE_BLIST_CHAT_NODE:
            __chat_node_cb(node, blist_cbs["remove"])
        elif node.type == blist.PURPLE_BLIST_OTHER_NODE:
            __other_node_cb(node, blist_cbs["remove"])

cdef void destroy(blist.PurpleBuddyList *list):
    """
    When the list gets destroyed, this gets called to destroy the UI.
    """
    debug.purple_debug_info("blist", "%s", "destroy\n")
    if blist_cbs.has_key("destroy"):
        (<object> blist_cbs["destroy"])("destroy: TODO")

cdef void set_visible(blist.PurpleBuddyList *list, glib.gboolean show):
    """
    Hides or unhides the buddy list.
    """
    debug.purple_debug_info("blist", "%s", "set-visible\n")
    if blist_cbs.has_key("set-visible"):
        (<object> blist_cbs["set-visible"])("set-visible: TODO")

cdef void request_add_buddy(account.PurpleAccount *acc, \
        const_char *username, const_char *group, const_char *alias):
    """
    TODO
    """
    debug.purple_debug_info("blist", "%s", "request-add-buddy\n")
    if blist_cbs.has_key("request-add-buddy"):
        (<object> blist_cbs["request-add-buddy"])("request-add-buddy: TODO")

cdef void request_add_chat(account.PurpleAccount *acc, \
        blist.PurpleGroup *group, const_char *alias, const_char *name):
    """
    TODO
    """
    debug.purple_debug_info("blist", "%s", "request-add-chat\n")
    if blist_cbs.has_key("request-add-chat"):
        (<object> blist_cbs["request-add-chat"])("request-add-chat: TODO")

cdef void request_add_group():
    """
    TODO
    """
    debug.purple_debug_info("blist", "%s", "request-add-group\n")
    if blist_cbs.has_key("request-add-chat"):
        (<object>blist_cbs["request-add-chat"])("request-add-group: TODO")
