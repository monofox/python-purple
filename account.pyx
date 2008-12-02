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

from protocol import Protocol

cdef class Account:
    """
    Account class
    @param username
    @param protocol_id
    """

    def __init__(self, username, protocol_id):
        self.__username = username
        self.__protocol_id = Protocol(self, protocol_id)

        if self.__get_structure() == NULL:
            self.__exists = False
        else:
            self.__exists = True

    def __get_username(self):
        return self.__username
    username = property(__get_username)

    def __get_protocol_id(self):
        return self.__protocol_id.protocol_id
    protocol_id = property(__get_protocol_id)

    def __get_exists(self):
        return self.__exists
    exists = property(__get_exists)

    cdef purple.account.PurpleAccount *__get_structure(self):
        return purple.account.purple_accounts_find(self.username, self.protocol_id)

    def new(self):
        if self.__exists:
            return False

        purple.account.purple_account_new(self.username, self.protocol_id)
        self.__exists = True
        return True
