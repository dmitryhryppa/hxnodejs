package js.node.tls;

import js.node.net.Socket.NetworkAdress;

@:enum abstract CleartextStreamEvent(String) to String {
	/**
		This event is emitted after a new connection has been successfully handshaked.

		The listener will be called no matter if the server's certificate was authorized or not.
		It is up to the user to test cleartextStream.authorized to see if the server certificate was signed by one of the specified CAs.
		If cleartextStream.authorized == false then the error can be found in cleartextStream.authorizationError.
		Also if NPN was used - you can check cleartextStream.npnProtocol for negotiated protocol.

		Listener arguments:
			cleartextStream : ClearTextStream
			encryptedStream : EncryptedStream
	**/
	var SecureConnect = "secureConnect";
}

/**
	This is a stream on top of the Encrypted stream that
	makes it possible to read/write an encrypted data as a cleartext data.

	A `ClearTextStream` is the `cleartext` member of a `SecurePair` object.
**/
extern class CleartextStream extends CryptoStream {

	/**
		A boolean that is true if the peer certificate was signed by one of the specified CAs, otherwise false
	**/
	var authorized(default,null):Bool;

	/**
		The reason why the peer's certificate has not been verified.
		This property becomes available only when `authorized` is false.
	**/
	var authorizationError(default,null):String;

	/**
		The string representation of the remote IP address.
		For example, '74.125.127.100' or '2001:4860:a005::68'.
	**/
	var remoteAddress(default,null):String;

	/**
		The numeric representation of the remote port.
		For example, 443.
	**/
	var remotePort(default,null):Int;

	/**
		Returns an object representing the peer's certificate.
		The returned object has some properties corresponding to the field of the certificate.
		If the peer does not provide a certificate, it returns null or an empty object.
	**/
	function getPeerCertificate():Dynamic<Dynamic>; // TODO: do we want a type for this?

	/**
		Returns an object representing the cipher name and the SSL/TLS protocol version of the current connection.
		Example: { name: 'AES256-SHA', version: 'TLSv1/SSLv3' }

		See SSL_CIPHER_get_name() and SSL_CIPHER_get_version() in http://www.openssl.org/docs/ssl/ssl.html#DEALING_WITH_CIPHERS
		for more information.
	**/
	function getCipher():{name:String, version:String};

	/**
		Returns the bound address, the address family name and port
		of the underlying socket as reported by the operating system.
	**/
	function address():NetworkAdress;
}
