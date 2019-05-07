/*
 Copyright (c) 2007 Eric J. Feminella  <eric@ericfeminella.com>
 All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 @internal
 */

package 
{

    import com.adobe.crypto.MD5;
    //import com.adobe.crypto.SHA1;
    import flash.utils.ByteArray;
   
   // import mx.utils.SHA256;
    /**
     * 
     * Provides an all static API which wraps the SHA1, SHA-256 and 
     * MD5 encryption algorithms, respectively, in order to allow a 
     * supported encryption algorithm to be applied to a String
     * 
     * @example the following example demonstrates a typical Encryption
     * implementation
     * 
     * <listing version="3.0">
     * 
     * var password:String = "EricFeminella1234";
     * 
     * trace( Encryption.encrypt( password, Encryption.CRYPTO_MD5 ) );
     * //0c7bf2ea20952abbc67e81c41bd19565
     * 
     * </listing>
     * 
     * @see com.adobe.crypto.MD5
     * @see com.adobe.crypto.SHA1
     * @see mx.utils.SHA256
     * 
     */    
    public final class Encryption
    {
        /**
         * 
         * Defines the constant which represents an SHA-256 hash 
         * algorithm 
         * 
         */
      //  public static const CRYPTO_SHA256:String = "SHA-256";
        
        /**
         * 
         * Defines the constant which represents a US Secure 
         * Hash Algorithm 1 (SHA1)
         * 
         */
       // public static const CRYPTO_SHA1:String   = "SHA1";
        
        /**
         * 
         * Defines the constant which represents an MD5 Message
         * Digest Algorithm
         * 
         */
        public static const CRYPTO_MD5:String    = "MD5";
        
        /**
         * 
         * Provides a utility operation from which a String is encrypted
         * to the specified encryption
         * 
         * @example the following example demonstrates each Encryption
         * type being performed on the same String
         * 
         * <listing version="3.0">
         * 
         * var password:String = "EricFeminella1234";
         * 
         * trace( Encryption.encrypt( password, Encryption.CRYPTO_MD5 ) );
         * //0c7bf2ea20952abbc67e81c41bd19565
         * 
         * trace( Encryption.encrypt( password, Encryption.CRYPTO_SHA1 ) );
         * //b40dee5836e7b407e6c7c398fc89e63c61dab760
         * 
         * trace( Encryption.encrypt( password, Encryption.CRYPTO_SHA256) );
         * //0a88111852095cae045340ea1f0b279944b2a756a213d9b50107d7489771e159 
         * 
         * </listing>
         * 
         * @param  the String which is to be encrypted
         * @param  a constant representing the required encryption
         * @return an encrypted version of the source parameter
         * 
         */        
        public static function encrypt(source:String, type:String) : String
        {
            var encryption:String;
            
            switch ( type )
            {
                case CRYPTO_MD5:
                   encryption = MD5.hash( source );
                   break;
                //case CRYPTO_SHA1:
                  // encryption = SHA1.hash( source );
                  // break;
                //case CRYPTO_SHA256:
                  // var ba:ByteArray = new ByteArray();
                   //ba.writeUTFBytes( source )
                  // encryption = SHA256.computeDigest( ba );
                 //  break; 
            }
            return encryption;
        }
    }
}
