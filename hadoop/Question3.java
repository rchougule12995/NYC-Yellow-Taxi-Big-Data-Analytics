import java.io.IOException;
import java.util.Iterator;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


public class Question3 {

static class AvgPassengerMapper extends Mapper<LongWritable, Text, Text, IntWritable> {

	public void map(LongWritable key, Text value, Mapper<LongWritable, Text, Text, IntWritable>.Context context) throws IOException, InterruptedException {

	      String[] columns = value.toString().split(",");
	      context.write(new Text(columns[9]), new IntWritable(1));
	}
}

static class AvgPassengerReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
	public void reduce(Text key, Iterable<IntWritable> values, Reducer<Text, IntWritable, Text, IntWritable>.Context con) throws IOException, InterruptedException {
	      int sum = 0;

	      IntWritable value;
	      for(Iterator<IntWritable> iterator = values.iterator(); iterator.hasNext(); sum += value.get()) {
	         value = (IntWritable)iterator.next();
	      }

	      con.write(key, new IntWritable(sum));
	   }		
}


 public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    Job job = Job.getInstance(conf, "Question3");
    job.setJarByClass(Question3.class);
    job.setMapperClass(AvgPassengerMapper.class);
    job.setReducerClass(AvgPassengerReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
