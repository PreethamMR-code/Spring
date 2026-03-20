package com.nexmeet.platform.service.impl;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.service.CertificateService;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

@Service
public class CertificateServiceImpl implements CertificateService {


    @Override
    public ByteArrayOutputStream generateTicket(Registration registration, String qrBase64) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            Document document = new Document(PageSize.A5);
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            document.open();

            PdfContentByte canvas = writer.getDirectContent();

            // Outer border
            canvas.setColorStroke(new BaseColor(0, 102, 204));
            canvas.setLineWidth(6f);
            canvas.rectangle(15, 15,
                    document.getPageSize().getWidth() - 30,
                    document.getPageSize().getHeight() - 30);
            canvas.stroke();

            // Fonts
            Font platformFont = new Font(Font.FontFamily.HELVETICA, 10,
                    Font.BOLD, new BaseColor(0, 102, 204));
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 16,
                    Font.BOLD, BaseColor.BLACK);
            Font labelFont = new Font(Font.FontFamily.HELVETICA, 9,
                    Font.BOLD, BaseColor.GRAY);
            Font valueFont = new Font(Font.FontFamily.HELVETICA, 11,
                    Font.NORMAL, BaseColor.BLACK);
            Font footerFont = new Font(Font.FontFamily.HELVETICA, 8,
                    Font.ITALIC, BaseColor.GRAY);
            Font warningFont = new Font(Font.FontFamily.HELVETICA, 9,
                    Font.BOLD, new BaseColor(200, 0, 0));

            // Header
            Paragraph platform = new Paragraph("NexMeet Conference Platform", platformFont);
            platform.setAlignment(Element.ALIGN_CENTER);
            platform.setSpacingBefore(15);
            document.add(platform);

            document.add(new Chunk(new LineSeparator(1f, 100f,
                    new BaseColor(0, 102, 204), Element.ALIGN_CENTER, -2)));

            // Conference Title
            Paragraph confTitle = new Paragraph(
                    registration.getConference().getTitle(), titleFont);
            confTitle.setAlignment(Element.ALIGN_CENTER);
            confTitle.setSpacingBefore(10);
            confTitle.setSpacingAfter(10);
            document.add(confTitle);

            // QR Code - large and centered
            if (qrBase64 != null && !qrBase64.isEmpty()) {
                byte[] qrBytes = java.util.Base64.getDecoder().decode(qrBase64);
                Image qrImage = Image.getInstance(qrBytes);
                qrImage.scaleAbsolute(180, 180);
                qrImage.setAlignment(Element.ALIGN_CENTER);
                document.add(qrImage);
            }

            // Registration number under QR
            Paragraph regNo = new Paragraph(
                    registration.getRegistrationNumber(), titleFont);
            regNo.setAlignment(Element.ALIGN_CENTER);
            regNo.setSpacingBefore(5);
            document.add(regNo);

            document.add(new Chunk(new LineSeparator(1f, 90f,
                    BaseColor.LIGHT_GRAY, Element.ALIGN_CENTER, -2)));

            // Details table
            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(90);
            table.setSpacingBefore(10);
            table.setWidths(new float[]{35f, 65f});

            addTicketRow(table, "Delegate", registration.getUser().getFullName(),
                    labelFont, valueFont);
            addTicketRow(table, "Date",
                    registration.getConference().getStartDate()
                            .format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")),
                    labelFont, valueFont);

            String venue = registration.getConference().getVenueName() != null
                    ? registration.getConference().getVenueName() : "Online";
            addTicketRow(table, "Venue", venue, labelFont, valueFont);

            String address = "";
            if (registration.getConference().getVenueAddress() != null) {
                address = registration.getConference().getVenueAddress();
            }
            if (registration.getConference().getCity() != null) {
                address += ", " + registration.getConference().getCity();
            }
            if (registration.getConference().getState() != null) {
                address += ", " + registration.getConference().getState();
            }
            if (!address.isEmpty()) {
                addTicketRow(table, "Address", address, labelFont, valueFont);
            }

            addTicketRow(table, "Mode",
                    registration.getConference().getMode().toString(),
                    labelFont, valueFont);
            addTicketRow(table, "Organizer",
                    registration.getConference().getOrganizer().getOrganizationName(),
                    labelFont, valueFont);

            String fee = registration.getConference().isFree() ? "Free" :
                    "₹" + registration.getConference().getDelegateFee();
            addTicketRow(table, "Entry Fee", fee, labelFont, valueFont);

            document.add(table);

            // Footer warning
            Paragraph warning = new Paragraph(
                    " Valid for one entry only. Show this ticket at the entrance.",
                    warningFont);
            warning.setAlignment(Element.ALIGN_CENTER);
            warning.setSpacingBefore(10);
            document.add(warning);

            Paragraph footer = new Paragraph(
                    "Generated by NexMeet · nexmeet.com", footerFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();

        } catch (Exception e) {
            throw new RuntimeException("Ticket generation failed: " + e.getMessage());
        }
        return baos;
    }

    private void addTicketRow(PdfPTable table, String label, String value,
                              Font labelFont, Font valueFont) {
        PdfPCell labelCell = new PdfPCell(new Phrase(label, labelFont));
        labelCell.setBorder(Rectangle.BOTTOM);
        labelCell.setBorderColor(BaseColor.LIGHT_GRAY);
        labelCell.setPadding(5);
        table.addCell(labelCell);

        PdfPCell valueCell = new PdfPCell(new Phrase(value, valueFont));
        valueCell.setBorder(Rectangle.BOTTOM);
        valueCell.setBorderColor(BaseColor.LIGHT_GRAY);
        valueCell.setPadding(5);
        table.addCell(valueCell);
    }

    @Override
    public ByteArrayOutputStream generateCertificate(Registration registration) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            // A4 Landscape
            Document document = new Document(PageSize.A4.rotate());
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            document.open();

            PdfContentByte canvas = writer.getDirectContent();

            // Border
            canvas.setColorStroke(new BaseColor(34, 139, 34));
            canvas.setLineWidth(8f);
            canvas.rectangle(20, 20,
                    document.getPageSize().getWidth() - 40,
                    document.getPageSize().getHeight() - 40);
            canvas.stroke();


            // Inner border
            canvas.setColorStroke(new BaseColor(144, 238, 144));
            canvas.setLineWidth(2f);
            canvas.rectangle(30, 30,
                    document.getPageSize().getWidth() - 60,
                    document.getPageSize().getHeight() - 60);
            canvas.stroke();

            // Fonts
            Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 42,
                    Font.BOLD, new BaseColor(34, 139, 34));
            Font subtitleFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
                    Font.ITALIC, BaseColor.DARK_GRAY);
            Font nameFont = new Font(Font.FontFamily.TIMES_ROMAN, 36,
                    Font.BOLD, new BaseColor(0, 100, 0));
            Font bodyFont = new Font(Font.FontFamily.TIMES_ROMAN, 16,
                    Font.NORMAL, BaseColor.BLACK);
            Font conferenceFont = new Font(Font.FontFamily.TIMES_ROMAN, 20,
                    Font.BOLD | Font.ITALIC, new BaseColor(34, 139, 34));
            Font smallFont = new Font(Font.FontFamily.TIMES_ROMAN, 12,
                    Font.NORMAL, BaseColor.GRAY);


            // Title
            Paragraph title = new Paragraph("Certificate of Participation", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingBefore(60);
            document.add(title);

            // Subtitle
            Paragraph subtitle = new Paragraph("This is to certify that", subtitleFont);
            subtitle.setAlignment(Element.ALIGN_CENTER);
            subtitle.setSpacingBefore(20);
            document.add(subtitle);

            // Delegate Name
            String delegateName = registration.getUser().getFullName();
            Paragraph name = new Paragraph(delegateName, nameFont);
            name.setAlignment(Element.ALIGN_CENTER);
            name.setSpacingBefore(15);
            document.add(name);

            // Horizontal line under name
            LineSeparator line = new LineSeparator();
            line.setLineColor(new BaseColor(34, 139, 34));
            line.setLineWidth(1f);
            line.setPercentage(50f);
            document.add(new Chunk(line));

            // Body text
            Paragraph body = new Paragraph(
                    "has successfully participated in the conference",
                    bodyFont);
            body.setAlignment(Element.ALIGN_CENTER);
            body.setSpacingBefore(20);
            document.add(body);

            // Conference Name
            String confName = registration.getConference().getTitle();
            Paragraph confTitle = new Paragraph(confName, conferenceFont);
            confTitle.setAlignment(Element.ALIGN_CENTER);
            confTitle.setSpacingBefore(10);
            document.add(confTitle);

            // Date and Location
            String startDate = registration.getConference().getStartDate()
                    .format(DateTimeFormatter.ofPattern("dd MMMM yyyy"));
            String city = registration.getConference().getCity() != null
                    ? registration.getConference().getCity() : "";
            String state = registration.getConference().getState() != null
                    ? registration.getConference().getState() : "";

            Paragraph datePlace = new Paragraph(
                    "Held on " + startDate + "  |  " + city + ", " + state,
                    bodyFont);
            datePlace.setAlignment(Element.ALIGN_CENTER);
            datePlace.setSpacingBefore(10);
            document.add(datePlace);

            // Organizer
            String orgName = registration.getConference().getOrganizer()
                    .getOrganizationName();
            Paragraph organizer = new Paragraph(
                    "Organized by: " + orgName, bodyFont);
            organizer.setAlignment(Element.ALIGN_CENTER);
            organizer.setSpacingBefore(10);
            document.add(organizer);

            // Registration Number
            Paragraph regNum = new Paragraph(
                    "Registration No: " + registration.getRegistrationNumber(),
                    smallFont);
            regNum.setAlignment(Element.ALIGN_CENTER);
            regNum.setSpacingBefore(30);
            document.add(regNum);

            // Footer line
            document.add(new Chunk(new LineSeparator()));

            // Footer
            Paragraph footer = new Paragraph("NexMeet Conference Platform", smallFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();

        } catch (DocumentException e) {
            throw new RuntimeException("Certificate generation failed: " + e.getMessage());
        }
        return baos;
        }
}
