import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


public class Question2 {

	static class AvgPassengerMapper extends Mapper<Object, Text, Text, FloatWritable> {

		public void map(Object key, Text value, Context context) throws IOException,
		InterruptedException {

			String [] columns = value.toString().split(",");

				try {
					Date date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(columns[1]);
					context.write(new Text("Average_TripDistance"), new FloatWritable(Float.parseFloat(columns[4])));
					context.write(new Text(new SimpleDateFormat("EEEE").format(date)),new FloatWritable(Float.parseFloat(columns[4])));
				}catch(NumberFormatException e) {
					e.printStackTrace();
				} catch (ParseException e) {
					e.printStackTrace();
				}
		}
	}

	static class AvgPassengerReducer extends Reducer<Text, FloatWritable, Text, FloatWritable> {
		public void reduce(Text key, Iterable<FloatWritable> values, Context context) throws IOException, InterruptedException {
			  float sum = 0;
			  int count = 0;

		      for(Iterator<FloatWritable> iterator = values.iterator(); iterator.hasNext(); ++count) {
		         FloatWritable value = (FloatWritable)iterator.next();
		         sum += value.get();
		      }

		      context.write(key, new FloatWritable(sum / (float)count));

		}
	}


	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		Job job = Job.getInstance(conf, "Question2");
		job.setJarByClass(Question2.class);
		job.setMapperClass(AvgPassengerMapper.class);
		job.setReducerClass(AvgPassengerReducer.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(FloatWritable.class);
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}