package pdfreader.aib.com.pdf_reader;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.ParcelFileDescriptor;

import com.shockwave.pdfium.PdfDocument;
import com.shockwave.pdfium.PdfiumCore;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import vn.aib.ratedialog.RatingDialog;

public class MainActivity extends FlutterActivity implements RatingDialog.RatingDialogInterFace {
  private static final String CHANNEL = "pdfViewer";
  ArrayList<String> listFile = new ArrayList<>();
  private int i = 0;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall( MethodCall methodCall, MethodChannel.Result result) {
                String filePath = methodCall.argument("filePath");

                switch(methodCall.method) {
                  case "loadFile":
                    loadFile(result);
                    break;
                  case "getThum":
                    Uri myUri = Uri.parse("file://"+filePath);
                    generateImageFromPdf(myUri,result);
                    break;
                  case "rate":
                    showRateDialog();
                    break;
                }
              }
            }
    );

  }

  void generateImageFromPdf(Uri pdfUri,MethodChannel.Result result) {

    int pageNumber = 0;
    PdfiumCore pdfiumCore = new PdfiumCore(this);
    try {
      ParcelFileDescriptor fd = getContentResolver().openFileDescriptor(pdfUri, "r");
      PdfDocument pdfDocument = pdfiumCore.newDocument(fd);
      pdfiumCore.openPage(pdfDocument, pageNumber);
      int width = pdfiumCore.getPageWidthPoint(pdfDocument, pageNumber);
      int height = pdfiumCore.getPageHeightPoint(pdfDocument, pageNumber);
      Bitmap bmp = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
      pdfiumCore.renderPageBitmap(pdfDocument, bmp, pageNumber, 0, 0, width, height);
//      Log.d("image:", "saveImage0: ");
      saveImage(bmp,result);
      pdfiumCore.closeDocument(pdfDocument); // important!
    } catch(Exception e) {
      result.success("");
      Log.e("Errr", "generateImageFromPdf: " + e.getMessage() );
    }
  }
  public final static String FOLDER = Environment.getExternalStorageDirectory() + "/PDF";
  private void saveImage(Bitmap bmp,MethodChannel.Result result) {
    FileOutputStream out = null;
    try {
      File folder = new File(FOLDER);
      if(!folder.exists())
        folder.mkdirs();
      File file = new File(folder, "PDF"+i+".png");
      i++;
      out = new FileOutputStream(file);
      bmp.compress(Bitmap.CompressFormat.PNG, 100, out);
      result.success(file.getAbsolutePath());
//      Log.d("image:", "saveImage: "+file.getAbsoluteFile());
      // bmp is your Bitmap instance
    } catch (Exception e) {
      //todo with exception
      result.success("");
//      Log.e("image:", "saveImage1: ");
    } finally {
      try {
        if (out != null)
          out.close();
      } catch (Exception e) {
        //todo with exception
      }
    }
  }

  public void loadFile(MethodChannel.Result result){
    listFile.clear();
    listFile = new ArrayList<>();
    Search_Dir(Environment.getExternalStorageDirectory());
    result.success(listFile);
  }
  public void Search_Dir(File dir) {
    String pdfPattern = ".pdf";
    File FileList[] = dir.listFiles();
    if (FileList != null) {
      for (int i = 0; i < FileList.length; i++) {
        if (FileList[i].isDirectory()) {
          Search_Dir(FileList[i]);
        } else {
          if (FileList[i].getName().endsWith(pdfPattern)){
            //here you have that file.
            listFile.add(FileList[i].getPath());
          }
        }
      }
    }

  }

  public void showRateDialog() {
    int count = SharedPrefsUtils.getInstance(this).getInt("rate");
    if (count < 2) {
      RatingDialog ratingDialog = new RatingDialog(this);
      ratingDialog.setRatingDialogListener(this);
      ratingDialog.showDialog();
    }
  }

  @Override
  public void onDismiss() {

  }

  @Override
  public void onSubmit(float rating) {
    if(rating > 3)
    {
      int count = SharedPrefsUtils.getInstance(this).getInt("rate");
      count++;
      SharedPrefsUtils.getInstance(this).putInt("rate", count);
      rateApp(this);
    }
  }

  @Override
  public void onRatingChanged(float v) {

  }

  public static void rateApp(Context context) {
    Intent intent = new Intent(new Intent(Intent.ACTION_VIEW,
            Uri.parse("http://play.google.com/store/apps/details?id=" + context.getPackageName())));
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    context.startActivity(intent);
  }
}
