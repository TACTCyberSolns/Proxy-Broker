import Pyro.core
import Pyro.naming
import logging
import sys

class PRCServer(object):
	def __init__(self):
		Pyro.core.initServer()
		self.daemon = Pyro.core.Daemon()
		self.log = logging.getLogger("pbmain")
	def rpc_server(self):
		"""
		RPCServer is intended for use as a seperate thread... This class
		will launch an RPCServer that can send & receive debugging events
		to debugging clients...
		"""
	def add_remote_obj(self, obj, name):
		self.log.info((RPCServer: add_remote_obj - adding remote object % "
						" with remote object name '%s'") % (obj, name))
		uri = self.daemon.connect(obj,name)
	def star_server(self):
		self.log.info("RPCServer: start_server - starting up")
		try:
			self.daemon.requestLoop()
		except:
			self.log.error("Failed to start daemon")
			self.log.error(sys.exc_info())
