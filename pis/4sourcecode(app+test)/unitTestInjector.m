classdef unitTestInjector < matlab.unittest.TestCase
 
    methods(Test)
 
        function testInit(testCase) %T1.1
            % State: First initialize of the injector system
            % Input: Null
            % Expected Output: the object of injector system with some properties
            % preset
            inj=injector;
            testCase.verifyEqual(inj.inject_rate, 0.01);
            testCase.verifyEqual(inj.bolus_volume, 0.2);
            testCase.verifyEqual(inj.inject_log, []);
        end
        
        function testupdaterate(testCase) %T1.2
            % State: there is an update of baseline injecting rate
            % Input: injector system and a target rate
            % Expected Output: 1) initialized injector 2)the injector with baseline rate updated 
            %
            %
            inj=injector;
            new_base = 0.05;
            inj.update_rate(new_base);
            testCase.verifyEqual(inj.inject_rate, new_base);
        end
 
        function testupdatebolus(testCase) %T1.3
            % State: there is an update of bolus injecting rate
            % Input: injector system and a target bolus volume
            % Expected Output: 1) initialized injector 2)the injector with bolus volume updated 
            %
            %
            inj=injector;
            new_volume = 0.3;
            inj.update_bolus(new_volume);
            testCase.verifyEqual(inj.bolus_volume, new_volume);
        end
        
        function testinjection(testCase) %T1.4
            % State: there is a injection happens at current moment
            % Input: injector system and its baseline injection rate
            % Expected Output: 1) initialized injector 2)a log that has
            % recorded the most recent injection
            %
            %
            inj=injector;
            inj.inject(inj.inject_rate);
            testCase.verifyEqual(inj.inject_log(end), inj.inject_rate);
        end
        
        function testbolus(testCase) %T1.5
            % State: there is a bolus shot happens at current moment
            % Input: injector system and a bolus input
            % Expected Output: 1) initialized injector 2)a log that has
            % recorded the most recent bolus
            %
            %
            inj=injector;
            inj.patient_enmergency(inj.bolus_volume);
            testCase.verifyEqual(inj.inject_log(end), inj.bolus_volume);
        end
        
        function tsettimefly(testCase)%T1.6
            % State: No action in the current moemnt
            % Input: injector system
            % Expected Output: 1) initialized injector 2)a log that has
            % a 0 at the end
            inj=injector;
            inj.timefly();
            testCase.verifyEqual(inj.inject_log(end), 0);
        end
        
        function testwipe(testCase) %T1.7
            % State: Need to reset the whole system
            % Input: injector system a current base rate and a current volume
            % Expected Output: 1) initialized injector 2)a log that has
            % been cleared 3)Default injection rate 4)Default bolus volume 
            inj=injector;
            current_volume = 0.3;
            inj.update_rate(current_volume);
            current_base = 0.05;
            inj.update_rate(current_base);
            inj.wipe();
            testCase.verifyEqual(inj.inject_rate, 0.01);
            testCase.verifyEqual(inj.bolus_volume, 0.2);
            testCase.verifyEqual(inj.inject_log, []);
        end
        
        
    end
 
end