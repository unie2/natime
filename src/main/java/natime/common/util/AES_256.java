package natime.common.util;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;

@Component("AES_256")
public class AES_256 {
    private String iv;
    private Key keySpec;


    public AES_256() throws UnsupportedEncodingException {
        String key = "01012345678yhn0101234567812345"; // 키 나중에 보안관련 키 관리 생각하기
        this.iv = key.substring(0, 16);
        byte[] keyBytes = new byte[16];
        byte[] b = key.getBytes("UTF-8");
        int len = b.length;
        if(len > keyBytes.length){
            len = keyBytes.length;
        }
        System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");

        this.keySpec = keySpec;
    }

    public String encrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException{
        if(str == null || str.length() == 0){
            return null;
        } else {
            Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
            c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes("UTF-8")));
            byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
            String enStr = new String(Base64.encodeBase64(encrypted));
            return enStr;
        }

    }

    public String decrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException {
        if(str == null || str.length() == 0){
            return null;
        } else {
            Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
            c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
            byte[] byteStr = Base64.decodeBase64(str.getBytes());
            return new String(c.doFinal(byteStr), "UTF-8");
        }

    }
}
