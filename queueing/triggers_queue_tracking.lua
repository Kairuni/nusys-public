-- You will execute the following command when you recover balance next: kick illikaal
-- [Balance Queue]:
-- [Equilibrium Queue]: diag
-- [Secondary Queue]: fulcrum flare Illikaal##kick Illikaal
-- You will execute the following command when you recover fulcrum balance next: fulcrum flare Illikaal
-- You will execute the following command when you next regain equilibrium and balance: kick Illikaal
-- You will execute the following command when you recover anabiotic balance next: eat anabiotic

TRIG.register("queue_clear_all", "exact", "All queues cleared.", function() QUE.clearAllQueues(); end);
TRIG.register("queue_clear_used", "regex", [[\[([\w\s]+) Queue\]\:]],
    function()
        QUE.clearedSomeQueue(matches[2]:lower());
    end);
TRIG.register("queue_clear", "regex", [[You have cleared your ([\w\s]+) queue\.$]], function() QUE.clearedSomeQueue(matches[2]); end);
--TRIG.register("queue_catcher_eqbal", "regex", [[^You will execute the following command when you next regain equilibrium and balance\:\s(.+)]], function() QUE.onEnqueue("eqbal", matches[2]) end);
TRIG.register("queue_catcher_other", "regex", [[^When you can ([\w\s]+)\:\s(.+)]], function() QUE.onEnqueue(matches[2], matches[3]) end);