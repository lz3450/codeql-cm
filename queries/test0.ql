/**
 * @name test0
 * @id at-ws/test0
 */

import python
import semmle.python.dataflow.new.DataFlow
import semmle.python.ApiGraphs

////////////////////////////////////////////////////////////////////////////////
// from File f
// select f, f.getBaseName()
////////////////////////////////////////////////////////////////////////////////
// from API::Node node, int numParams
// where
//   node.getLocation().getFile().getBaseName() = "test0.py" and
//   node = API::moduleImport("builtins").getMember("print") and
//   numParams = node.getNumParameter()
// select node, numParams.toString()
////////////////////////////////////////////////////////////////////////////////
// from DataFlow::CallCfgNode call, int numParams
// where
//   call.getLocation().getFile().getBaseName() = "test0.py" and
//   call = API::moduleImport("builtins").getMember("print").getACall() and
//   numParams = call.getNode().getNumParameter()
// select call, numParams.toString()
////////////////////////////////////////////////////////////////////////////////
// from API::Node node
// where
//   node = API::builtin("print") and
//   node.getLocation().getFile().getBaseName() = "test0.py"
// select node, node.getNumParameter().toString()
////////////////////////////////////////////////////////////////////////////////
// from IntegerLiteral literal
// select literal, literal.getValue().toString()
////////////////////////////////////////////////////////////////////////////////
// from DataFlow::Node source, DataFlow::Node sink, Expr expr
// where
//   sink.getLocation().getFile().getBaseName() = "test0.py" and
//   sink = API::builtin("print").getACall().getArg(0) and
//   DataFlow::localFlow(source, sink) and
//   expr = source.asExpr() and
//   expr instanceof BinaryExpr
// select source, expr.(BinaryExpr).getLeft(), expr.(BinaryExpr).getOp(), expr.(BinaryExpr).getRight()
////////////////////////////////////////////////////////////////////////////////
// from DataFlow::Node sink
// where
//   sink.getLocation().getFile().getBaseName() = "test0.py"
// select sink
////////////////////////////////////////////////////////////////////////////////
// from DataFlow::Node sink, DataFlow::Node source
// where
//   sink.getLocation().getFile().getBaseName() = "test0.py" and
//   sink = API::builtin("print").getACall().getArg(0) and
//   DataFlow::localFlowStep+(source, sink)
// select source, source.asExpr().toString()
////////////////////////////////////////////////////////////////////////////////
// from DataFlow::Node sink, DataFlow::Node source
// where
//   sink.getLocation().getFile().getBaseName() = "test0.py" and
//   sink.asExpr() instanceof BinaryExpr and
//   DataFlow::localFlowStep+(source, sink)
// select sink, sink.asExpr().toString()
////////////////////////////////////////////////////////////////////////////////
from DataFlow::Node sink, DataFlow::Node source
where
  sink.getLocation().getFile().getBaseName() = "test0.py" and
  source.getLocation().getFile().getBaseName() = "test0.py" and
  DataFlow::localFlowStep(source, sink)
select source, sink
////////////////////////////////////////////////////////////////////////////////
// module MyFlowConfiguration implements DataFlow::ConfigSig {
//   predicate isSource(DataFlow::Node source) {
//     source.getLocation().getFile().getBaseName() = "test0.py"
//   }

//   predicate isSink(DataFlow::Node sink) {
//     sink.getLocation().getFile().getBaseName() = "test0.py" and
//     sink = API::builtin("print").getACall().getArg(0)
//   }
// }

// module MyFlow = DataFlow::Global<MyFlowConfiguration>;

// from DataFlow::Node source, DataFlow::Node sink
// where MyFlow::flow(source, sink)
// select source, sink
