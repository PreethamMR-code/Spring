package com.nexmeet.platform.service.impl;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.nexmeet.platform.service.QrCodeService;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.util.Base64;


@Service
public class QrCodeServiceImpl implements QrCodeService {


    @Override
    public String generateQrCodeBase64(String text) {
        try {
            QRCodeWriter writer = new QRCodeWriter();
            BitMatrix bitMatrix = writer.encode(text, BarcodeFormat.QR_CODE, 250, 250);
            BufferedImage image = MatrixToImageWriter.toBufferedImage(bitMatrix);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(image, "PNG", baos);
            return Base64.getEncoder().encodeToString(baos.toByteArray());
        } catch (WriterException | java.io.IOException e) {
            throw new RuntimeException("QR generation failed: " + e.getMessage());
        }
    }
}
