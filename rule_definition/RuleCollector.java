import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class RuleCollector {

  public static void main(String[] args) {
    System.out.println("hello");

    if (args.length < 1) {
      System.out.println("Must specify input file");
      System.exit(0);
    }

    String inputFileName = args[0];
    System.out.println("Input filename: " + inputFileName);

    String outputFileName;
    if (args.length > 1) {
      outputFileName = args[1];
    } else {
      outputFileName = "repositories.bzl";
    }
    System.out.println("Output filename: " + outputFileName);

    try {
      // create writer
      BufferedWriter writer = new BufferedWriter(new FileWriter(outputFileName));
      writer.write("load(\"@bazel_tools//tools/build_defs/repo:jvm.bzl\", \"jvm_maven_import_external\")" + "\n");
      writer.write("def maven_repositories():\n");

      // create reader
      BufferedReader reader = new BufferedReader(new FileReader(inputFileName));
      String line;
      while ((line = reader.readLine()) != null) {
        writer.write("    " + line + "\n");
      }

      writer.close();
      reader.close();


    } catch (IOException e) {
      // FIXME handle this exception properly - see go/java-practices/exceptions
      throw new AssertionError("Unhandled exception", e);
    }

  }
}
