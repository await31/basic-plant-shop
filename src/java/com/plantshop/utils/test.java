
import com.plantshop.dao.AccountDAO;
import com.plantshop.dao.OrderDAO;
import com.plantshop.dto.Account;
import com.plantshop.dto.Order;
import java.util.*;
import java.io.*;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

class test {

    public static String generateOTP() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            int index = (int) (chars.length() * Math.random());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }

    public static void main(String[] argh) {
        System.out.println(generateOTP());
    }
}
