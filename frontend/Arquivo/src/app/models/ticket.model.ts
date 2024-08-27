import { User } from "./user.model";

export interface Ticket {
  id: number;
  creationDate: Date;
  requesterName: string;   
  email: string;           
  phone: string;           
  description: string;
  hoursOpen: number;
  startDate: Date;
  endDate: Date;
  status: string;
  resolution: string;    
  user: User;            
}
