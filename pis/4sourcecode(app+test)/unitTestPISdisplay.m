classdef unitTestPISdisplay < matlab.unittest.TestCase
 
    
    methods(Test)
    
        function testLivecase1(tc)%T1.2.1.1
            % State: injecting over 1 day and overamount
            % Input: 1)PISdisplay UI 2)an inject_log length>86400 with all
            % 0.02 3)houramount = dayamount= 3600*0.02 4)injection switch
            % is off 5)power is on
            % Expected Output: 1)houramountgauge=3599*0.02 2)dayamountgauge=3599*0.02
            % 3)the indicating light turns yellow
            
            UI=PISdisplay();
            UI.PowerSwitch.Value='On';
            UI.InjectionSwitch.Value='Off';
            UI.HourAmountGauge.Value=3600*0.02;
            UI.DayamountGauge.Value=3600*0.02;
            UI.cc.inject_log=zeros(1,864001)+0.02;
            UI.live();
            tc.verifyEqual(round(UI.HourAmountGauge.Value,7),round(3599*0.02,7));
            tc.verifyEqual(round(UI.DayamountGauge.Value,7),round(3599*0.02,7));
            tc.verifyEqual(UI.powerlight.Color,[1,1,0]);
            delete(UI)
            
            
        end
        function testLivecase2(tc)%T1.2.1.2
            % State: no current injection
            % Input: 1)PISdisplay UI 2)an inject_log length=10 with all
            % 0.02 3)houramount = dayamount= 0 4)injection switch
            % is off 5)power is on
            % Expected Output: 1)log(end)==0 2)the indicating light turns green
            UI=PISdisplay();
            UI.PowerSwitch.Value='On';
            UI.InjectionSwitch.Value='Off';
            UI.HourAmountGauge.Value=0;
            UI.DayamountGauge.Value=0;
            UI.cc.inject_log=zeros(1,10)+0.02;
            UI.live();
            tc.verifyEqual(UI.cc.inject_log(end),0);
            tc.verifyEqual(UI.powerlight.Color,[0,1,0]);
            delete(UI)
            
        end
        function testLivecase3(tc)%T1.2.1.3
            % State: Normal injection 
            % Input: 1)PISdisplay UI 2)an inject_log length=10 with all
            % 0.02 3)houramount = dayamount= 0.2 4)injection switch
            % is on 5)power is on 6)injection_rate=0.02*60
            % Expected Output: 1)log(end)==0.02 2)HourAmountGauge==0.22
            % 3)DayamountGauge==0.22
            UI=PISdisplay();
            UI.PowerSwitch.Value='On';
            UI.InjectionSwitch.Value='On';
            UI.cc.inject_rate=0.02*60;
            UI.HourAmountGauge.Value=0.2;
            UI.DayamountGauge.Value=0.2;
            UI.cc.inject_log=zeros(1,10)+0.02;
            UI.live();
            tc.verifyEqual(UI.cc.inject_log(end),0.02);
            tc.verifyEqual(UI.HourAmountGauge.Value,0.22);
            tc.verifyEqual(UI.DayamountGauge.Value,0.22);
            delete(UI)
        end
        function testwipe(tc)%T1.2.2
            % State: Need to reset the system and call wipe()
            % Input: 1)PISdisplay UI 2)an inject_log length=10 with all
            % 0.02 3)houramount = dayamount= 0.2 4)injection switch
            % is on 5)power is on 6)injection_rate=0.02*60
            % Expected Output: 1)log==[] 2)HourAmountGauge==0
            % 3)DayamountGauge==0
            UI=PISdisplay();
            UI.PowerSwitch.Value='On';
            UI.InjectionSwitch.Value='On';
            UI.cc.inject_rate=0.02*60;
            UI.HourAmountGauge.Value=0.2;
            UI.DayamountGauge.Value=0.2;
            UI.cc.inject_log=zeros(1,10)+0.02;
            UI.wipe();
            tc.verifyEqual(UI.cc.inject_log,[]);
            tc.verifyEqual(UI.HourAmountGauge.Value,0);
            tc.verifyEqual(UI.DayamountGauge.Value,0);
            tc.verifyEqual(UI.InjectionSwitch.Value,'Off');
            delete(UI)
        end
        function testPatient(tc)%T1.2.3
            % State: To inject a bolus for patients
            % Input: 1)PISdisplay UI 2)an inject_log length=10 with all
            % 0.02 3)power is on 4)dayamount = houramount = 0.02
            % Expected Output: 1)log==[end] == bolus_volume 2)dayamount = 0.02+bolus_volume
            % 3)houramount=0.02+bolus_volume
            UI=PISdisplay();
            UI.PowerSwitch.Value='On';
            UI.HourAmountGauge.Value=0.2;
            UI.DayamountGauge.Value=0.2;
            UI.cc.inject_log=zeros(1,10)+0.02;
            UI.patient();
            tc.verifyEqual(UI.cc.inject_log(end),UI.cc.bolus_volume);
            tc.verifyEqual(UI.HourAmountGauge.Value,0.2+UI.cc.bolus_volume);
            tc.verifyEqual(UI.DayamountGauge.Value,0.2+UI.cc.bolus_volume);
            delete(UI)
        end
    end
end