package com.greejoy.station.domain;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-12
 * Time: 上午9:57
 * To change this template use File | Settings | File Templates.
 */
public class PicResized {
    public static byte[] resizeByBytes(byte[] originalFile, int width, String format) throws IOException {
        ImageIcon ii = new ImageIcon(originalFile);
        Image inputImage = ii.getImage();
        int imageWidth = inputImage.getWidth( null );
        if ( imageWidth < 20 )
            throw new IllegalArgumentException( "image width " + imageWidth + " is out of range" );
        int imageHeight = inputImage.getHeight( null );
        if ( imageHeight < 20 )
            throw new IllegalArgumentException( "image height " + imageHeight + " is out of range" );

        // Create output image.
        int height = -1;
        double scaleW = (double) imageWidth / (double) width;
        double scaleY = (double) imageHeight / (double) height;
        if (scaleW >= 0 && scaleY >=0) {
            if (scaleW > scaleY) {
                height = -1;
            } else {
                width = -1;
            }
        }
        Image outputImage = inputImage.getScaledInstance( width, height, Image.SCALE_SMOOTH);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        encode(byteArrayOutputStream, outputImage, format);
        byte[] resizedFile = byteArrayOutputStream.toByteArray();
        return resizedFile;
    }

    /** Encodes the given image at the given quality to the output stream. */
    private static void encode( OutputStream outputStream, Image outputImage, String format )
       throws IOException {
       int outputWidth  = outputImage.getWidth( null );
       int outputHeight = outputImage.getHeight( null );
       // Get a buffered image from the image.
       BufferedImage bi = new BufferedImage( outputWidth, outputHeight,
          BufferedImage.TYPE_3BYTE_BGR );
       Graphics2D biContext = bi.createGraphics();
       biContext.drawImage( outputImage, 0, 0, null );
       ImageIO.write(bi, format, outputStream);
       outputStream.flush();
       outputStream.close();
    }
}
