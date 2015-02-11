#!/usr/bin/env python
# +--------------------------------------------------------------------------+
# | Penlook Project                                                          |
# +--------------------------------------------------------------------------+
# | Copyright (c) 2015 Penlook Development Team                              |
# +--------------------------------------------------------------------------+
# |                                                                          |
# | This program is free software: you can redistribute it and/or modify     |
# | it under the terms of the GNU Affero General Public License as           |
# | published by the Free Software Foundation, either version 3 of the       |
# | License, or (at your option) any later version.                          |
# |                                                                          |
# | This program is distributed in the hope that it will be useful, but	     |
# | WITHOUT ANY WARRANTY; without even the implied warranty of               |
# | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            |
# | GNU Affero General Public License for more details.                      |
# |                                                                          |
# | You should have received a copy of the GNU Affero General Public License |
# | along with this program.  If not, see <http://www.gnu.org/licenses/>.    |
# |                                                                          |
# +--------------------------------------------------------------------------+
# |   Author: Loi Nguyen  <loint@penlook.com>                                |
# +--------------------------------------------------------------------------+

from command import *
import unittest
import os.path
import random

class TestCommand(unittest.TestCase):

	def setUp(self):
		self.file = "/tmp/test-" + str(random.randint(1, 100000)) + ".txt"

	def tearDown(self):
		pass

	def test_mkfile_delete(self):

		self.assertEqual(False, os.path.exists(self.file))
		mkfile(self.file)

		self.assertEqual(True, os.path.isfile(self.file))
		delete(self.file)

	def test_copy(self):
		mkfile(self.file)
		test_file = "/var/log/test.text"

		self.assertEqual(False, os.path.exists(test_file))
		copy(self.file, test_file)
		self.assertEqual(True, os.path.exists(test_file))

		delete(self.file)
		delete(test_file)

		self.assertEqual(False, os.path.exists(self.file))
		self.assertEqual(False, os.path.exists(test_file))

	def test_move(self):
		mkfile(self.file)
		test_file = "/var/log/test.text"

		self.assertEqual(False, os.path.exists(test_file))
		move(self.file, test_file)

		self.assertEqual(True, os.path.exists(test_file))
		self.assertEqual(False, os.path.exists(self.file))

		delete(test_file)
		self.assertEqual(False, os.path.exists(test_file))

	def test_runnable(self):
		pass

	def test_writable(self):
		pass

