collection = []

# Lambda's
expected_lambda = "Hello Lambda".freeze

# To assign a closure to a variable Use lambda keyword
# This lambda will add e into collection
lambda_block = lambda { |e| collection << e }


# This passes the lambda 'lambda_block' to the each_char method in Array.
# The & prepended to the variable 'lambda_block' is called a unary & and is the 
# equivalent of calling lambda_block.to_proc
result_of_lambda = expected_lambda.each_char &lambda_block

raise "Was expecting #{expected_lambda} but got #{result_of_lambda}" unless expected_lambda == result_of_lambda
raise "Was expecting #{expected_lambda} but got #{collection.join}" unless expected_lambda == collection.join

expected_lambda_return = "expected lambda return value"
# The return call to lambda will reuturn to the calling method in order for it to proceed (The proc block would return immediatly)
def lambda_method
   lambda_a = lambda { |e| return e }
   l = lambda_a.call("unexpected lambda return value")
   raise "Was expecting unexpected lambda return value but got #{l}" unless "unexpected lambda return value" == l
   @expected_lambda_return
end
raise "Was expecting #{@expected_lambda_return} but got #{lambda_method}" unless @expected_lambda_return == lambda_method


# Procs
collection.clear
expected_proc = "Hello Proc"

# Proc is a slightly differnt lambda implementation. Proc.new and proc can be used interchangably
proc_block = Proc.new { |e,f| collection << e }

result_of_proc = expected_proc.each_char &proc_block
raise "Was expecting #{expected_proc} but got #{collection.join}" unless expected_proc == collection.join

#Procs dont care about the number of arguments. We can add whatever here
proc_block.call(); proc_block.call(1,2,3,); 
# Lambdas care about the number of arguments
lambda_block.call(1)

@expected_proc_return = "expected proc return value"
# When the proc block returns it will return immediatly from the calling method (lambda will return to the calling method)
def proc_method
	proc_a = proc { |x| return x }
	proc_a.call(@expected_proc_return)
	"unexpected proc return"
end
raise "Was expecting #{@expected_proc_return} but got #{proc_method}" unless @expected_proc_return == proc_method


@expected_proc_return_from_nested_example = @expected_proc_return << " from proc_method_nested_example"
# The nested example proves that although the proc block returns 
# immediatly the class calling the method containing the proc
# also does not return immediatly
def proc_method_nested_example
	proc_method
	@expected_proc_return_from_nested_example 
end

raise "Was expecting #{@expected_proc_return_from_nested_example} but got #{proc_method_nested_example}" unless @expected_proc_return_from_nested_example == proc_method_nested_example