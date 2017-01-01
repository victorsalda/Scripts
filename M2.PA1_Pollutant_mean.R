pollutantmean<-function(directory,pollutant,id=1:332){
        setwd("C:/Victor/Estudios/6.MOOCs/RProgramming/ProgAssig1")
        directory<-"C:/Victor/Estudios/6.MOOCs/RProgramming/ProgAssig1"
        files_full<-list.files(directory)
        dat<-data.frame()
        for (i in id){
                dat<-rbind(dat, read.csv(files_full[i]))
        } 
        dat_subset<-dat[,pollutant]
        mean(dat_subset,na.rm=TRUE)
        print()
}