classdef uiTestPKI < matlab.uitest.TestCase
    properties
        physician
    end
    
    methods(TestMethodSetup)
        function createApp(testcase) 
            testcase.physician = PISdisplay;
            testcase.addTeardown(@delete,testcase.physician);     
        end
    end
    
    methods(Test)
        
        function testPower(tc) %T3.1
            % State:
            % Input:
            % ExpectedOutput:
            %

        	tc.press(tc.physician.PowerSwitch);
            pause(1);
            tc.verifyEqual(tc.physician.PowerSwitch.Value,'On');
            pause(1);
            
            tc.press(tc.physician.PowerSwitch);
            pause(1);
            
        end
        
        function testBaselineKnob(tc) %T3.2
            % State:
            % Input:
            % ExpectedOutput:
            %            
            tc.press(tc.physician.PowerSwitch);
            tc.drag(tc.physician.baselinerate,0.02,0.05);
            tc.verifyEqual(round(tc.physician.baselinerate.Value,2),0.05);
            pause(1);
            try tc.drag(tc.physician.baselinerate,0.02,1); catch;end
            tc.verifyEqual(round(tc.physician.baselinerate.Value,2),0.05);
            pause(1);
            tc.press(tc.physician.PowerSwitch);
            pause(1);
        end
        
        function testBolusKnob(tc) %T3.3
            % State:
            % Input:
            % ExpectedOutput:
            %
            tc.press(tc.physician.PowerSwitch);
            tc.drag(tc.physician.PerBolusKnob,0.2,0.35);
            tc.verifyEqual(round(tc.physician.PerBolusKnob.Value,3),0.35);
            pause(1);
            try tc.drag(tc.physician.PerBolusKnob,0.2,1); catch;end
            tc.verifyEqual(round(tc.physician.PerBolusKnob.Value,3),0.35);
            tc.press(tc.physician.PowerSwitch);
            pause(1);
        end
        
        
        function testInjection(tc) %T3.4
            % State:
            % Input:
            % ExpectedOutput:
            %
            tc.press(tc.physician.PowerSwitch);
            
            tc.drag(tc.physician.TimeScalingSlider,1,80);
            tc.press(tc.physician.InjectionSwitch);
            pause(1);
            tc.verifyEqual(tc.physician.InjectionSwitch.Value,'On');
            pause(1);
            tc.drag(tc.physician.baselinerate,0.02,0.05);
            pause(3);
            tc.press(tc.physician.InjectionSwitch);
            pause(1);
            tc.press(tc.physician.PowerSwitch);
            pause(1);
        end
        
        function testLock(tc) %T3.5
            % State:
            % Input:
            % ExpectedOutput:
            %
            tc.press(tc.physician.PowerSwitch);
            tc.drag(tc.physician.TimeScalingSlider,1,80);
            tc.press(tc.physician.LockButton);
            pause(1);
            tc.press(tc.physician.InjectionSwitch);
            pause(1);
            tc.drag(tc.physician.baselinerate,0.02,0.05);
            pause(1);
            tc.verifyEqual(tc.physician.InjectionSwitch.Value,'Off');
            pause(1);

            tc.press(tc.physician.UnlockButton);
            pause(1);
            tc.drag(tc.physician.baselinerate,0.02,0.05);
            pause(1);
            tc.press(tc.physician.InjectionSwitch);
            tc.verifyEqual(tc.physician.InjectionSwitch.Value,'On');
            pause(5);
            tc.press(tc.physician.PowerSwitch);
            pause(1);
        end
        
        function testPatient(tc) %T3.6
            % State:
            % Input:
            % ExpectedOutput:
            %
            tc.press(tc.physician.PowerSwitch);
            tc.drag(tc.physician.TimeScalingSlider,1,80);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.LockButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.UnlockButton);
            pause(1);
            tc.press(tc.physician.PowerSwitch);
            pause(1);
        end
        
        function testNormalUse(tc) %T3.7
            % State:
            % Input:
            % ExpectedOutput:
            %
            tc.press(tc.physician.PowerSwitch);
            tc.drag(tc.physician.TimeScalingSlider,1,50);
            tc.press(tc.physician.InjectionSwitch);
            pause(1);
            tc.verifyEqual(tc.physician.InjectionSwitch.Value,'On');
            pause(1);
            tc.drag(tc.physician.baselinerate,0.02,0.05);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.LockButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.UnlockButton);
            pause(1);
            tc.press(tc.physician.InjectionSwitch);
            pause(1);
            tc.press(tc.physician.PowerSwitch);
            pause(1);
        end
        
        function testOvershoot(tc) %T3.8
            % State:
            % Input:
            % ExpectedOutput:
            %
            tc.press(tc.physician.PowerSwitch);
            tc.drag(tc.physician.TimeScalingSlider,1,100);
            tc.drag(tc.physician.baselinerate,0.02,0.1);
            tc.press(tc.physician.InjectionSwitch);
            pause(10);
            tc.press(tc.physician.PowerSwitch);
            tc.press(tc.physician.PowerSwitch);
            tc.drag(tc.physician.TimeScalingSlider,1,50);
            tc.press(tc.physician.InjectionSwitch);
            pause(1);
            tc.verifyEqual(tc.physician.InjectionSwitch.Value,'On');
            pause(1);
            tc.drag(tc.physician.baselinerate,0.02,0.05);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.LockButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.UnlockButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.InjectionSwitch);
            pause(1);
            tc.press(tc.physician.PowerSwitch);
            pause(1);
            tc.press(tc.physician.PowerSwitch);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.drag(tc.physician.PerBolusKnob,0.2,0.35);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.Patient_UI.PatientButton);
            pause(1);
            tc.press(tc.physician.PowerSwitch);
            pause(1);
        end
    end
    
    
    
end