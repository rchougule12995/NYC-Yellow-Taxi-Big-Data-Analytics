import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


public class Question1 {

	static class AvgPassengerMapper extends Mapper<Object, Text, Text, IntWritable> {

		public void map(Object key, Text value, Context context) throws IOException,
		InterruptedException {

			String [] columns = value.toString().split(",");

				try {
					Date date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(columns[1]);
					context.write(new Text("Average_Passengers"), new IntWritable(Integer.parseInt(columns[3])));
					context.write(new Text(new SimpleDateFormat("EEEE").format(date)),new IntWritable(Integer.parseInt(columns[3])));
				} catch (ParseException e) {
					e.printStackTrace();
				}
		}
	}

	static class AvgPassengerReducer extends Reducer<Text, IntWritable, Text, FloatWritable> {
		public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
			  int sum = 0,count = 0;

		      for(Iterator<IntWritable> iterator = values.iterator(); iterator.hasNext(); ++count) {
		         IntWritable value = (IntWritable)iterator.next();
		         sum += value.get();
		      }

		      context.write(key, new FloatWritable((float)sum / (float)count));

		}
	}


	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		Job job = Job.getInstance(conf, "Question1");
		job.setJarByClass(Question1.class);
		job.setMapperClass(AvgPassengerMapper.class);
		job.setReducerClass(AvgPassengerReducer.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}