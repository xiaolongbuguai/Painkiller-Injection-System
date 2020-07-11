classdef injector < handle
    
    properties
        inject_rate
        bolus_volume
        inject_log
        
    end
    
    methods
        
        function obj =injector(a)
            obj.inject_rate = 0.01;
            obj.bolus_volume = 0.2;
            obj.inject_log = [];
        end
        
        function update_rate(this,new_rate)
            this.inject_rate = new_rate;    
        end
        
        function update_bolus(this,new_bolus)
            this.bolus_volume = new_bolus;
        end
        
        function inject(this,little)
            this.inject_log(end+1) = little;
        end
        
        function patient_enmergency(this,vol)
            this.inject_log(end+1) = vol;
        end
        
        function wipe(this)
            this.inject_rate = 0.01;
            this.bolus_volume = 0.2;
            this.inject_log =[];
            
        end
        
        function timefly(this)
            this.inject_log(end+1) = 0;
        end
    end
end


