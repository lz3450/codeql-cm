/**
 * @name test2
 * @id at-ws/test2
 */

import python
import semmle.python.dataflow.new.DataFlow
import semmle.python.ApiGraphs

from DataFlow::Node sink, DataFlow::Node source
where
  sink.getLocation().getFile().getBaseName() = "test2.py" and
  source.getLocation().getFile().getBaseName() = "test2.py" and
  DataFlow::localFlowStep(source, sink)
select source, sink
