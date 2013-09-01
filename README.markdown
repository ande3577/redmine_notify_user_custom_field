# Redmine Notify User Custom Field

## Overview

This plugin adds a 'Notify User' option to a user-type custom field.  If this 
option is set, any user mentioned in the field will receive an e-mail 
notification if the issue is changed.  The notification will only be sent if the 
user has his/her email notification setting to 'Only to issues I watch or am 
involved in' or higher.

This project is intended as a rough workaround to the problem of multiple 
assignees in cases where group creation is impractical.  In this scenario, the 
primary person responsable for implementing the issue will be named as the 
assignee, while additional people involved will be named in a custom field.
All uses involved will then receive e-mail notification.  Unlike the watcher 
function, the custom field can be used for managing queries and a user cannot
unwatch an issue if they are selected.

The feature can be enabled on the custom field's settings page.

Please report issues to: 
  https://github.com/ande3577/redmine_notify_user_custom_field/issues
  
Tested on 2.3 and 2.4.  May or may not work on other versions.

## Installation

1.  Clone to plugins/redmine_notify_user_custom_field
1.  Migrate the database
1.  Restart the server

## License

This program is free software: you can redistribute it and/or modify 
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
